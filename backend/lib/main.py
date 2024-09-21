from pathlib import Path

from lib.floor_cv import FloorCV

if __name__ == '__main__':
    current_dir = Path(__file__).resolve().parent
    root_dir = current_dir.parent
    sample_path = root_dir / 'assets' / 'sample.jpg'
    sample_path_str = str(sample_path)

    img_grayscale = FloorCV.read_grayscale_img(sample_path_str)
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
    img_lines = FloorCV.get_line_img(img_structure, lines)
    FloorCV.log_image(root_dir, img_lines, 'lines')

    intersections, new_lines = FloorCV.get_all_intersections(img_lines, lines)
    print(f'Filtered Lines: {len(new_lines)}')
    print(f'Intersections: {len(intersections)}')
    img_lines = FloorCV.get_line_img(img_structure, lines)
    FloorCV.log_image(root_dir, img_lines, 'new_lines')
    FloorCV.export_intersections(root_dir, img_lines, intersections)

    corners = FloorCV.find_table_corners(intersections)
    img_mask = FloorCV.create_rectangular_mask(img_lines, corners)
    FloorCV.log_image(root_dir, img_mask, 'raw_mask')

    img_masked_lines = FloorCV.apply_mask(img_lines, img_mask)
    FloorCV.log_image(root_dir, img_masked_lines, 'masked')

    img_straightened = FloorCV.straighten_table(img_masked_lines, corners)
    FloorCV.log_image(root_dir, img_straightened, 'straightened')

    cells = FloorCV.find_cells(img_straightened)
    img_straightened_bgr = FloorCV.img_to_bgr(img_straightened)
    FloorCV.export_cells(root_dir, cells, img_straightened_bgr)
