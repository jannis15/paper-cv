import uuid
from pathlib import Path
import numpy as np
import cv2 as cv
from typing import List, Tuple
from shapely.geometry import LineString, Point, box
from abc import ABC


class Cell:
    def __init__(self, x, y, width, height):
        self.x = x
        self.y = y
        self.width = width
        self.height = height


class FloorCV(ABC):
    @staticmethod
    def read_grayscale_img(filename: str) -> np.ndarray:
        return cv.imread(filename, cv.IMREAD_GRAYSCALE)

    @staticmethod
    def img_to_bgr(img: np.ndarray) -> np.ndarray:
        return cv.cvtColor(img, cv.COLOR_GRAY2BGR)

    @staticmethod
    def apply_gaussian_blur(img: np.ndarray) -> np.ndarray:
        return cv.GaussianBlur(img, (7, 7), 0)

    @staticmethod
    def apply_adaptive_threshold_with_inversion(img: np.ndarray) -> np.ndarray:
        return cv.adaptiveThreshold(img, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY_INV, 11, 5)

    @staticmethod
    def get_structuring_elements(img: np.ndarray) -> np.ndarray:
        horizontal_kernel = cv.getStructuringElement(cv.MORPH_RECT, (20, 1))
        vertical_kernel = cv.getStructuringElement(cv.MORPH_RECT, (1, 20))
        horizontal_lines = cv.morphologyEx(img, cv.MORPH_OPEN, horizontal_kernel, iterations=2)
        vertical_lines = cv.morphologyEx(img, cv.MORPH_OPEN, vertical_kernel, iterations=2)
        return cv.add(horizontal_lines, vertical_lines)

    @staticmethod
    def log_image(root_dir: Path, img: np.ndarray, title: str) -> None:
        unique_id = uuid.uuid4()
        output_path = root_dir / 'outputs' / f'{title}_{unique_id}.jpg'
        cv.imwrite(str(output_path), img)

    @staticmethod
    def find_table_corners(intersections: List[Point]) -> np.ndarray:
        top_left = Point(float('inf'), float('inf'))
        top_right = Point(float('-inf'), float('inf'))
        bottom_left = Point(float('inf'), float('-inf'))
        bottom_right = Point(float('-inf'), float('-inf'))
        top_left_sum = top_left.x + top_left.y
        top_right_sum = top_right.x - top_right.y
        bottom_left_sum = bottom_left.y - bottom_left.x
        bottom_right_sum = bottom_right.x + bottom_right.y
        for point in intersections:
            x, y = point.x, point.y
            point_sum = x + y
            top_right_point_sum = x - y
            bottom_left_point_sum = y - x
            if point_sum < top_left_sum:
                top_left = point
                top_left_sum = top_left.x + top_left.y
            if point_sum > bottom_right_sum:
                bottom_right = point
                bottom_right_sum = bottom_right.x + bottom_right.y
            if top_right_point_sum > top_right_sum:
                top_right = point
                top_right_sum = top_right.x - top_right.y
            if bottom_left_point_sum > bottom_left_sum:
                bottom_left = point
                bottom_left_sum = bottom_left.y - bottom_left.x
        corner_list = [top_left, top_right, bottom_right, bottom_left]
        corners_tuple = [[point.x, point.y] for point in corner_list]
        corners = np.array(corners_tuple, dtype=np.int32)
        return corners

    @staticmethod
    def create_rectangular_mask(img: np.ndarray, corner_points: np.ndarray) -> np.ndarray:
        mask_image = np.zeros_like(img)
        cv.fillConvexPoly(mask_image, corner_points, [255])
        return mask_image

    @staticmethod
    def apply_mask(img: np.ndarray, mask: np.ndarray) -> np.ndarray:
        mask = (mask > 0).astype(np.uint8) * 255
        masked_image = cv.bitwise_and(img, img, mask=mask)
        return masked_image

    @staticmethod
    def export_intersections(root_dir: Path, img: np.ndarray, intersections: List) -> None:
        intersection_canvas = np.zeros_like(img)
        intersection_canvas = FloorCV.img_to_bgr(intersection_canvas)
        for point in intersections:
            x, y = int(point.x), int(point.y)
            cv.circle(intersection_canvas, (x, y), 5, [0, 0, 255])
        FloorCV.log_image(root_dir, intersection_canvas, 'intersections')
        line_image_bgr = FloorCV.img_to_bgr(img)
        intersection_canvas = cv.addWeighted(line_image_bgr, .2, intersection_canvas, 1, 0)
        FloorCV.log_image(root_dir, intersection_canvas, 'lines_with_intersections')

    @staticmethod
    def extend_line(x1: float, y1: float, x2: float, y2: float, img: np.ndarray) -> np.ndarray:
        height, width = img[:2]
        dx = x2 - x1
        dy = y2 - y1
        if dx != 0:
            slope = dy / dx
            intercept = y1 - slope * x1
        else:
            slope = float('inf')
            intercept = x1

        if slope != float('inf'):
            # Calculate extended coordinates
            x1_extended = 0
            y1_extended = int(intercept)
            x2_extended = width
            y2_extended = int(slope * width + intercept)

            # Clip the extended line to image boundaries
            if y1_extended < 0:
                y1_extended = 0
                x1_extended = int((y1_extended - intercept) / slope)

            if y2_extended > height:
                y2_extended = height
                x2_extended = int((y2_extended - intercept) / slope)

            # Return as ndarray
            return np.array([x1_extended, y1_extended, x2_extended, y2_extended])
        else:
            # Vertical line case
            return np.array([intercept, 0, intercept, height])

    @staticmethod
    def find_cells(imh: np.ndarray) -> List[Cell]:
        kernel = np.ones((3, 3), np.uint8)
        imh = cv.dilate(imh, kernel, iterations=1)
        imh = cv.Canny(imh, 0, 0)
        contours, _ = cv.findContours(imh, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
        cells = []
        for contour in contours:
            x, y, width, height = cv.boundingRect(contour)
            # Filter small rectangles that are not cells
            if width > 10 and height > 10:  # Adjust this threshold as needed
                cells.append(Cell(x, y, width, height))
        return cells

    @staticmethod
    def export_cells(root_dir: Path, cells: List[Cell], img: np.ndarray) -> None:
        annotated_image = img.copy()
        for idx, cell in enumerate(cells):
            # Define the top-left and bottom-right corners of the rectangle
            top_left = (cell.x, cell.y)
            bottom_right = (cell.x + cell.width, cell.y + cell.height)

            # Draw a light red rectangle around the cell
            color = (0, 0, 255)  # BGR format: red color
            thickness = 2  # Thickness of the rectangle border
            cv.rectangle(annotated_image, top_left, bottom_right, color, thickness)

            # Put the index number in the center of the rectangle
            center_x = cell.x + cell.width // 2
            center_y = cell.y + cell.height // 2
            font = cv.FONT_HERSHEY_SIMPLEX
            font_scale = 0.7
            text_color = (0, 0, 255)  # Red color
            text_thickness = 2
            cv.putText(annotated_image, str(idx), (center_x - 10, center_y + 10), font, font_scale, text_color,
                       text_thickness)
        FloorCV.log_image(root_dir, annotated_image, 'annotated_image')

    @staticmethod
    def straighten_table(img: np.ndarray, src_corners: np.ndarray) -> np.ndarray:
        dst_corners = np.float32([
            [0, 0],  # Top-left
            [img.shape[1] - 1, 0],  # Top-right
            [img.shape[1] - 1, img.shape[0] - 1],  # Bottom-right
            [0, img.shape[0] - 1]  # Bottom-left
        ])
        src_corners = np.float32(src_corners)
        perspective_transform = cv.getPerspectiveTransform(src_corners, dst_corners)
        warped_image = cv.warpPerspective(img, perspective_transform, (img.shape[1], img.shape[0]))
        return warped_image

    @staticmethod
    def get_all_lines(img: np.ndarray) -> np.ndarray:
        return cv.HoughLinesP(image=img, rho=1, theta=np.pi / 180, threshold=400, minLineLength=50,
                              maxLineGap=100)

    @staticmethod
    def get_line_img(img: np.ndarray, lines: np.ndarray) -> np.ndarray:
        img_all_lines = np.zeros_like(img)
        if lines is None or len(lines) < 2:
            pass
        for i in range(len(lines)):
            for x1, y1, x2, y2 in lines[i]:
                lines[i] = FloorCV.extend_line(x1, y1, x2, y2, img_all_lines.shape)
                x1_ext, y1_ext, x2_ext, y2_ext = lines[i][0]
                cv.line(img_all_lines, [x1_ext, y1_ext], [x2_ext, y2_ext], [255], 1)
        return img_all_lines

    @staticmethod
    def get_all_intersections(img: np.ndarray, lines: np.ndarray) -> Tuple[List[Point], np.ndarray]:
        intersections = []
        img_height, img_width = img.shape[:2]
        image_box = box(0, 0, img_width, img_height)

        def is_within_existing_intersections(new_point: Point, existing_points: List[Point], threshold=10) -> bool:
            for existing_point in existing_points:
                distance = new_point.distance(existing_point)
                if distance < threshold:
                    return True
            return False

        lines_list = [line for line in lines]
        lines_length = len(lines_list)
        for i in range(lines_length - 1, -1, -1):
            x0_1, y0_1, x0_2, y0_2 = lines_list[i][0]
            line_str_a = LineString([(x0_1, y0_1), (x0_2, y0_2)])
            should_delete_line = False
            tmp_points = []
            for j in range(len(lines_list)):
                if i == j:
                    continue
                x1_1, y1_1, x1_2, y1_2 = lines_list[j][0]
                line_str_b = LineString([(x1_1, y1_1), (x1_2, y1_2)])
                point = line_str_a.intersection(line_str_b)
                if point is None or isinstance(point, LineString):
                    continue
                if not image_box.contains(point):
                    continue
                if is_within_existing_intersections(point, intersections):
                    should_delete_line = True
                    break
                tmp_points.append(point)
            if should_delete_line:
                lines_list.pop(i)
            else:
                for point in tmp_points:
                    intersections.append(point)

        filtered_lines = np.array(lines_list)
        return intersections, filtered_lines
