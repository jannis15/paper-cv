from abc import ABC
from pathlib import Path
from typing import List
import re

import numpy as np
from google.cloud import vision
from pydantic import constr

from lib.floor_cv import FloorCV, Cell
from lib.rect_fitter import find_best_fit
from lib.schemas import ScanResult, ScanProperties, Selection
import cv2 as cv

a4_height = 29.7
a4_width = 21
root_dir = Path(__file__).resolve().parent.parent
ALLOWED_PATTERN = r'^[A-Za-zÄÖÜäöüß,.\?!0-9\+\-\%\=\(\)\$€]+$'


class FloorCvController(ABC):
    @staticmethod
    def __detect_handwriting(client: vision.ImageAnnotatorClient, content: np.ndarray, column_widths: list) -> List[
        Cell]:
        def extract_cells_from_response(response) -> List[Cell]:
            cells = []
            for page in response.full_text_annotation.pages:
                for block in page.blocks:
                    for paragraph in block.paragraphs:
                        for word in paragraph.words:
                            word_text = ''.join(
                                [symbol.text for symbol in word.symbols if re.match(ALLOWED_PATTERN, symbol.text)])
                            word_bbox = [(vertex.x, vertex.y) for vertex in word.bounding_box.vertices]
                            x1, y1 = word_bbox[0]
                            x2, y2 = word_bbox[2]
                            cell = Cell(x1, y1, x2, y2)
                            cell.text = word_text
                            cells.append(cell)
            return cells

        current_x = 0
        image_height = content.shape[0]
        ocr_res = []
        for width in column_widths:
            next_x = current_x + round(width)
            cropped_image = content[0:image_height, current_x:next_x]
            _, cropped_content = cv.imencode('.jpg', cropped_image)
            FloorCV.log_image(root_dir, cropped_image, 'dfopigjijdioj')
            cropped_vision_image = vision.Image(content=cropped_content.tobytes())
            response = client.document_text_detection(image=cropped_vision_image,
                                                      image_context=vision.ImageContext(language_hints=["de"]))

            new_cells = extract_cells_from_response(response)
            for cell in new_cells:
                cell.transform(translate_x=current_x)
            ocr_res.extend(new_cells)
            current_x += round(width)
        return ocr_res

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
    def scan_file(client: vision.ImageAnnotatorClient, file_bytes: bytes, scan_properties: ScanProperties,
                  logging: bool = False):
        np_arr = np.frombuffer(file_bytes, np.uint8)
        img_grayscale = FloorCV.read_grayscale_img_from_bytes(np_arr)
        img_base = FloorCvController.__crop_image_by_selection(img_grayscale, scan_properties.selection)
        if logging:
            FloorCV.log_image(root_dir, img_base, '1_grayscale')

        img_gaussian_blur = FloorCV.apply_gaussian_blur(img_base)
        if logging:
            FloorCV.log_image(root_dir, img_gaussian_blur, '2_gaussian')

        img_threshold = FloorCV.apply_adaptive_threshold_with_inversion(img_gaussian_blur)
        if logging:
            FloorCV.log_image(root_dir, img_threshold, '3_threshold')

        img_structure = FloorCV.get_structuring_elements(img_threshold)
        if logging:
            FloorCV.log_image(root_dir, img_structure, '4_structure')

        lines = FloorCV.get_all_lines(img_structure)
        FloorCV.extend_all_lines(img_structure, lines)
        if logging:
            print(f'Lines: {len(lines)}')
            img_lines = FloorCV.add_lines_to_zeros_like_img(img_base, lines)
            FloorCV.log_image(root_dir, img_lines, '5_lines')

        intersections = FloorCV.get_all_intersections(img_base, lines)
        if logging:
            print(f'Intersections: {len(intersections)}')
            FloorCV.export_intersections(root_dir, img_structure, intersections)

        corners = FloorCV.get_table_corners(intersections)
        img_structure_straightened, lines, new_corners, perspective_transform = FloorCV.straighten_table(logging,
                                                                                                         img_structure,
                                                                                                         lines,
                                                                                                         corners)
        if logging:
            FloorCV.log_image(root_dir, img_structure_straightened, '7_structure_straightened')
            img_filtered_lines = FloorCV.add_lines_to_zeros_like_img(img_base, lines)
            FloorCV.log_image(root_dir, img_filtered_lines, '8_lines_straightened')

        FloorCV.add_lines_around_table(new_corners, lines)
        new_horizontal_lines, new_vertical_lines = FloorCV.filter_out_close_lines(lines)

        new_vertical_lines = FloorCV.straighten_vertical_lines(new_vertical_lines)
        new_vertical_lines = FloorCV.sort_vertical_lines_by_x(new_vertical_lines)
        new_horizontal_lines = FloorCV.straighten_horizontal_lines(new_horizontal_lines)
        new_horizontal_lines = FloorCV.sort_horizontal_lines_by_y(new_horizontal_lines)
        avg_vertical_distance = FloorCV.get_average_vertical_distance(new_horizontal_lines)
        rows = len(new_horizontal_lines) - 1
        columns = len(new_vertical_lines) - 1
        column_widths = FloorCV.get_column_widths(new_vertical_lines)
        # new_horizontal_lines = FloorCV.adjust_horizontal_lines_by_avg_vertical_distance(avg_vertical_distance,
        #                                                                                 new_horizontal_lines)
        filtered_lines = np.concatenate((new_horizontal_lines, new_vertical_lines), axis=0)
        filtered_lines = list(filtered_lines)
        img_filtered_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, filtered_lines)
        if logging:
            print(f'Filtered Lines: {len(filtered_lines)}')
            FloorCV.log_image(root_dir, img_filtered_lines, '9_filtered_lines')

        filtered_lines_cropped = img_filtered_lines[int(new_corners[0][1]):int(new_corners[2][1]),
                                 int(new_corners[0][0]):int(new_corners[2][0])]
        if logging:
            FloorCV.log_image(root_dir, filtered_lines_cropped, '91_filtered_lines_cropped')

        cells = FloorCV.find_cells(filtered_lines_cropped)
        cell_texts = ['' for _ in cells]
        if logging:
            filtered_lines_cropped_bgr = FloorCV.img_to_bgr(filtered_lines_cropped)
            FloorCV.export_cells(root_dir, cells, filtered_lines_cropped_bgr)

        if logging:
            img_structure_straightened_cropped = img_structure_straightened[
                                                 int(new_corners[0][1]):int(new_corners[2][1]),
                                                 int(new_corners[0][0]):int(new_corners[2][0])]
            FloorCV.log_image(root_dir, img=img_structure_straightened_cropped,
                              title='93_structure_straightened_cropped')

        # img_threshold_warped = FloorCV.warp_image(img_threshold, perspective_transform)
        # img_threshold_warped_cropped = img_threshold_warped[int(new_corners[0][1]):int(new_corners[2][1]),
        #                                int(new_corners[0][0]):int(new_corners[2][0])]
        # ocr_res = FloorCvController.__detect_handwriting(client=client, content=img_threshold_warped_cropped,
        #                                                  column_widths=column_widths)
        # if logging:
        #     FloorCV.log_image(root_dir, img_threshold_warped_cropped, '94_theshold_warped_cropped')
        #     FloorCV.add_lines_to_img(img_threshold_warped, filtered_lines)
        #     FloorCV.log_image(root_dir, img_threshold_warped, '95_theshold_warped_with_lines')
        # 
        # for cell in ocr_res:
        #     best_fit_index = find_best_fit(cells, cell)
        #     if best_fit_index is not None:
        #         if cell_texts[best_fit_index] != '':
        #             cell_texts[best_fit_index] += ' '
        #         cell_texts[best_fit_index] += cell.text.strip().strip('|').strip()
        # 
        # if logging:
        #     filtered_lines_cropped_bgr = FloorCV.img_to_bgr(filtered_lines_cropped)
        #     FloorCV.export_cells(root_dir, ocr_res, filtered_lines_cropped_bgr)

        cell_texts = FloorCV.make_2d_list(cell_texts, rows)

        img_height, img_width = img_grayscale.shape
        avg_vertical_distance_cm = (avg_vertical_distance / img_height) * a4_height

        column_widths_cm = []
        for column_width in column_widths:
            column_widths_cm.append((column_width / img_width) * a4_width)

        corner_x, corner_y = new_corners[0][0], new_corners[0][1]
        abs_corner_x = scan_properties.selection.x1 + corner_x
        abs_corner_y = scan_properties.selection.y1 + corner_y
        corner_x_cm = (abs_corner_x / img_width) * a4_width
        corner_y_cm = (abs_corner_y / img_height) * a4_height

        cell_texts = FloorCV.adjust_cell_texts_for_template(template_no=scan_properties.template_no,
                                                            cell_texts=cell_texts)

        return ScanResult(
            column_widths_cm=column_widths_cm,
            rows=rows,
            table_x_cm=corner_x_cm,
            table_y_cm=corner_y_cm,
            img_width_px=img_width,
            img_height_px=img_height,
            avg_row_height_cm=avg_vertical_distance_cm,
            cell_texts=cell_texts,
        )
