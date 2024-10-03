from abc import ABC
from pathlib import Path
import numpy as np
from google.cloud import vision
from lib.floor_cv import FloorCV
from lib.schemas import ScanProperties


class FloorCvController(ABC):
    @staticmethod
    def __detect_handwriting(client: vision.ImageAnnotatorClient, content: bytes):
        image = vision.Image(content=content)
        response = client.text_detection(image=image)
        texts = response.text_annotations

    @staticmethod
    def scan_file(client: vision.ImageAnnotatorClient, file_bytes: bytes):
        # FloorCvController.__detect_handwriting(client=client,content=file_bytes)
        current_dir = Path(__file__).resolve().parent
        root_dir = current_dir.parent
        np_arr = np.frombuffer(file_bytes, np.uint8)
        img_grayscale = FloorCV.read_grayscale_img_from_bytes(np_arr)
        FloorCV.log_image(root_dir, img_grayscale, 'grayscale')
        assert img_grayscale is not None, "file could not be read, check with os.path.exists()"

        img_gaussian_blur = FloorCV.apply_gaussian_blur(img_grayscale)
        FloorCV.log_image(root_dir, img_gaussian_blur, 'gaussian_blur')

        img_threshold = FloorCV.apply_adaptive_threshold_with_inversion(img_gaussian_blur)
        FloorCV.log_image(root_dir, img_threshold, 'adaptive_threshold_with_inversion')

        img_structure = FloorCV.get_structuring_elements(img_threshold)
        FloorCV.log_image(root_dir, img_structure, 'structure')

        lines = FloorCV.get_all_lines(img_structure)
        print(f'Lines: {len(lines)}')
        FloorCV.extend_all_lines(img_structure, lines)
        img_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, lines)
        FloorCV.log_image(root_dir, img_lines, 'lines')

        intersections = FloorCV.get_all_intersections(img_lines, lines)
        # print(f'Filtered Lines: {len(new_lines)}')
        print(f'Intersections: {len(intersections)}')
        # img_lines = FloorCV.get_line_img(img_structure, lines)
        # FloorCV.log_image(root_dir, img_lines, 'new_lines')
        FloorCV.export_intersections(root_dir, img_lines, intersections)

        corners = FloorCV.get_table_corners(intersections)

        img_new_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, lines)

        img_straightened, lines, new_corners, perspective_transform = FloorCV.straighten_table(img_new_lines, lines,
                                                                                               corners)
        FloorCV.log_image(root_dir, img_straightened, 'straightened')
        img_new_lines = FloorCV.add_lines_to_zeros_like_img(img_straightened, lines)
        FloorCV.log_image(root_dir, img_new_lines, 'new_lines2')

        FloorCV.add_lines_around_table(new_corners, lines)
        new_horizontal_lines, new_vertical_lines = FloorCV.filter_out_close_lines(lines)

        new_vertical_lines = FloorCV.straighten_vertical_lines(new_vertical_lines)
        new_horizontal_lines = FloorCV.straighten_horizontal_lines(new_horizontal_lines)
        new_horizontal_lines = FloorCV.sort_horizontal_lines_by_y(new_horizontal_lines)
        avg_vertical_distance = FloorCV.average_vertical_distance(new_horizontal_lines)
        # new_horizontal_lines = FloorCV.adjust_horizontal_lines_by_avg_vertical_distance(avg_vertical_distance,
        #                                                                                 new_horizontal_lines)
        new_lines = np.concatenate((new_horizontal_lines, new_vertical_lines), axis=0)
        new_lines = list(new_lines)
        img_new_lines = FloorCV.add_lines_to_zeros_like_img(img_structure, new_lines)
        print(f'New Lines: {len(new_lines)}')
        FloorCV.log_image(root_dir, img_new_lines, 'new_lines')

        cropped_img = img_new_lines[int(new_corners[0][1]):int(new_corners[2][1]),
                      int(new_corners[0][0]):int(new_corners[2][0])]

        img_threshold_straightened = FloorCV.warp_image(img_threshold, perspective_transform)
        FloorCV.add_lines_to_img(img_threshold_straightened, new_lines)
        img_mask = FloorCV.create_rectangular_mask(img_threshold_straightened, new_corners)
        img_threshold_masked = FloorCV.apply_mask(img_threshold_straightened, img_mask)
        FloorCV.log_image(root_dir, img_threshold_masked, 'threshold_masked')

        cells = FloorCV.find_cells(cropped_img)
        img_straightened_bgr = FloorCV.img_to_bgr(cropped_img)
        FloorCV.export_cells(root_dir, cells, img_straightened_bgr)
        column_widths = FloorCV.get_column_widths(new_vertical_lines)

        return ScanProperties(
            column_widths=column_widths,
            rows=len(new_horizontal_lines)-1,
            avg_row_height=avg_vertical_distance,
            cell_texts=[],
        )
