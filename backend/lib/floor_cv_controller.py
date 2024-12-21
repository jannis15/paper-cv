from abc import ABC
from pathlib import Path
import numpy as np
from google.cloud import vision
from pydantic import constr

from lib.floor_cv import FloorCV, Cell
from lib.rect_fitter import find_best_fit
from lib.schemas import ScanProperties, Selection

a4_height = 29.7
a4_width = 21


class FloorCvController(ABC):
    @staticmethod
    def __detect_handwriting(client: vision.ImageAnnotatorClient, content: bytes):
        image = vision.Image(content=content)
        image_context = vision.ImageContext(
            language_hints=["de"]
        )
        return client.text_detection(image=image, image_context=image_context)

    @staticmethod
    def __crop_image_by_selection(image: np.ndarray, selection: Selection) -> np.ndarray:
        height, width = image.shape[:2]
        x1_clamped = int(max(0, min(selection.x1, width)))
        y1_clamped = int(max(0, min(selection.y1, height)))
        x2_clamped = int(max(0, min(selection.x2, width)))
        y2_clamped = int(max(0, min(selection.y2, height)))
        x1_clamped, x2_clamped = sorted([x1_clamped, x2_clamped])
        y1_clamped, y2_clamped = sorted([y1_clamped, y2_clamped])
        cropped_image = image[y1_clamped:y2_clamped, x1_clamped:x2_clamped]
        return cropped_image

    @staticmethod
    def scan_file(client: vision.ImageAnnotatorClient, file_bytes: bytes, selection: Selection):
        # current_dir = Path(__file__).resolve().parent
        # root_dir = current_dir.parent
        np_arr = np.frombuffer(file_bytes, np.uint8)
        img_grayscale = FloorCV.read_grayscale_img_from_bytes(np_arr)
        img_grayscale_cropped = FloorCvController.__crop_image_by_selection(img_grayscale, selection)
        # FloorCV.log_image(root_dir, img_grayscale_cropped, 'grayscale')

        img_gaussian_blur = FloorCV.apply_gaussian_blur(img_grayscale_cropped)
        # FloorCV.log_image(root_dir, img_gaussian_blur, 'gaussian_blur')

        img_threshold = FloorCV.apply_adaptive_threshold_with_inversion(img_gaussian_blur)
        # FloorCV.log_image(root_dir, img_threshold, 'adaptive_threshold_with_inversion')

        img_structure = FloorCV.get_structuring_elements(img_threshold)
        # FloorCV.log_image(root_dir, img_structure, 'structure')

        lines = FloorCV.get_all_lines(img_structure)
        # print(f'Lines: {len(lines)}')
        FloorCV.extend_all_lines(img_structure, lines)
        # img_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, lines)
        # FloorCV.log_image(root_dir, img_lines, 'lines')

        intersections = FloorCV.get_all_intersections(img_structure, lines)
        # print(f'Filtered Lines: {len(new_lines)}')
        # print(f'Intersections: {len(intersections)}')
        # img_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, lines)
        # FloorCV.log_image(root_dir, img_lines, 'new_lines')
        # FloorCV.export_intersections(root_dir, img_structure, intersections)

        corners = FloorCV.get_table_corners(intersections)

        # img_new_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, lines)

        img_straightened, lines, new_corners, perspective_transform = FloorCV.straighten_table(img_structure, lines,
                                                                                               corners)
        # FloorCV.log_image(root_dir, img_straightened, 'straightened')
        # img_new_lines = FloorCV.add_lines_to_zeros_like_img(img_straightened, lines)
        # FloorCV.log_image(root_dir, img_new_lines, 'new_lines2')

        FloorCV.add_lines_around_table(new_corners, lines)
        new_horizontal_lines, new_vertical_lines = FloorCV.filter_out_close_lines(lines)

        new_vertical_lines = FloorCV.straighten_vertical_lines(new_vertical_lines)
        new_vertical_lines = FloorCV.sort_vertical_lines_by_x(new_vertical_lines)
        new_horizontal_lines = FloorCV.straighten_horizontal_lines(new_horizontal_lines)
        new_horizontal_lines = FloorCV.sort_horizontal_lines_by_y(new_horizontal_lines)
        avg_vertical_distance = FloorCV.average_vertical_distance(new_horizontal_lines)
        new_horizontal_lines = FloorCV.adjust_horizontal_lines_by_avg_vertical_distance(avg_vertical_distance,
                                                                                        new_horizontal_lines)
        new_lines = np.concatenate((new_horizontal_lines, new_vertical_lines), axis=0)
        new_lines = list(new_lines)
        img_new_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, new_lines)
        # print(f'New Lines: {len(new_lines)}')
        # FloorCV.log_image(root_dir, img_new_lines, 'new_lines')

        cropped_img = img_new_lines[int(new_corners[0][1]):int(new_corners[2][1]),
                      int(new_corners[0][0]):int(new_corners[2][0])]

        # img_threshold_straightened = FloorCV.warp_image(img_threshold, perspective_transform)
        # FloorCV.add_lines_to_img(img_threshold_straightened, new_lines)
        # img_mask = FloorCV.create_rectangular_mask(img_threshold_straightened, new_corners)
        # img_threshold_masked = FloorCV.apply_mask(img_threshold_straightened, img_mask)
        # FloorCV.log_image(root_dir, img_threshold_masked, 'threshold_masked')

        # img_straightened_bgr = FloorCV.img_to_bgr(cropped_img)
        # FloorCV.export_cells(root_dir, cells, img_straightened_bgr)
        column_widths = FloorCV.get_column_widths(new_vertical_lines)

        cells = FloorCV.find_cells(cropped_img)
        cell_texts = ['' for _ in cells]

        img_handwriting_source = FloorCV.warp_image(img_threshold, perspective_transform)
        img_handwriting_source = img_handwriting_source[int(new_corners[0][1]):int(new_corners[2][1]),
                                 int(new_corners[0][0]):int(new_corners[2][0])]
        img_handwriting_source_bytes = FloorCV.ndarray_to_bytes(img_handwriting_source)

        # img_warped_structure = FloorCV.warp_image(img_structure, perspective_transform)
        # FloorCV.log_image(root_dir, img=img_warped_structure, title='asdf')
        # cropped_img_warped_structure = img_warped_structure[int(new_corners[0][1]):int(new_corners[2][1]),
        #               int(new_corners[0][0]):int(new_corners[2][0])]
        # FloorCV.log_image(root_dir, img=cropped_img_warped_structure, title='qwertz')
        # cropped_img_warped_structure_bytes = FloorCV.ndarray_to_bytes(cropped_img_warped_structure)

        # nparr = np.frombuffer(cropped_img_warped_structure_bytes, np.uint8)
        # import cv2 as cv
        # img = cv.imdecode(nparr, cv.IMREAD_COLOR)
        # FloorCV.log_image(root_dir=root_dir, img=img, title='yeehaw')

        ocr_res = FloorCvController.__detect_handwriting(client=client, content=img_handwriting_source_bytes)
        for annotation in ocr_res.text_annotations:
            annotation_corners = [[vertice.x, vertice.y] for vertice in annotation.bounding_poly.vertices]
            annotation_dst_corners = FloorCV.get_dst_corners(annotation_corners)
            annotation_cell = Cell(x1=annotation_dst_corners[0][0], y1=annotation_dst_corners[0][1],
                                   x2=annotation_dst_corners[2][0],
                                   y2=annotation_dst_corners[2][1])
            best_fit_index = find_best_fit(cells, annotation_cell)
            if best_fit_index is not None:
                if cell_texts[best_fit_index] != '':
                    cell_texts[best_fit_index] += ' '
                cell_texts[best_fit_index] += annotation.description

        rows = len(new_horizontal_lines) - 1
        columns = len(new_vertical_lines) - 1
        cell_texts = FloorCV.make_2d_list(cell_texts, columns)

        img_height, img_width = img_grayscale.shape
        avg_vertical_distance_cm = (avg_vertical_distance / img_height) * a4_height

        column_widths_cm = []
        for column_width in column_widths:
            column_widths_cm.append((column_width / img_width) * a4_width)

        return ScanProperties(
            column_widths_cm=column_widths_cm,
            rows=rows,
            avg_row_height_cm=avg_vertical_distance_cm,
            cell_texts=cell_texts,
        )
