from abc import ABC
from pathlib import Path

from lib.floor_cv import FloorCV


class FloorCvController(ABC):
    @staticmethod
    def scan_file(file):
        current_dir = Path(__file__).resolve().parent
        root_dir = current_dir.parent
        img_grayscale = FloorCV.read_grayscale_img_from_bytes(file)
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
        img_lines = FloorCV.get_line_img(img_structure, lines)
        FloorCV.log_image(root_dir, img_lines, 'lines')

        intersections = FloorCV.get_all_intersections(img_lines, lines)
        # print(f'Filtered Lines: {len(new_lines)}')
        print(f'Intersections: {len(intersections)}')
        # img_lines = FloorCV.get_line_img(img_structure, lines)
        # FloorCV.log_image(root_dir, img_lines, 'new_lines')
        FloorCV.export_intersections(root_dir, img_lines, intersections)

        corners = FloorCV.get_table_corners(intersections)
        img_straightened, lines, new_corners, perspective_transform = FloorCV.straighten_table(img_lines, lines,
                                                                                               corners)
        FloorCV.log_image(root_dir, img_straightened, 'straightened')

        FloorCV.add_lines_around_table(new_corners, lines)
        new_lines = FloorCV.filter_out_close_lines(lines)
        img_new_lines = FloorCV.get_line_img(img_structure, new_lines)
        print(f'New Lines: {len(new_lines)}')
        FloorCV.log_image(root_dir, img_new_lines, 'new_lines')
        # lines = FloorCV.get_all_lines(img_straightened)
        # FloorCV.extend_all_lines(img_straightened, lines)

        # img_mask = FloorCV.create_rectangular_mask(img_new_lines, new_corners)
        # FloorCV.log_image(root_dir, img_mask, 'raw_mask')
        # img_masked_lines = FloorCV.apply_mask(img_new_lines, img_mask)
        # FloorCV.log_image(root_dir, img_masked_lines, 'masked')
        cropped_img = img_new_lines[int(new_corners[0][1]):int(new_corners[2][1]),
                      int(new_corners[0][0]):int(new_corners[2][0])]

        cells = FloorCV.find_cells(cropped_img)
        img_straightened_bgr = FloorCV.img_to_bgr(cropped_img)
        FloorCV.export_cells(root_dir, cells, img_straightened_bgr)
