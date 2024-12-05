import uuid
from pathlib import Path
import numpy as np
import cv2 as cv
from typing import List, Tuple, Any
from shapely.geometry import LineString, Point, box
from abc import ABC


class Cell:
    def __init__(self, x1, y1, x2, y2):
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2

    @property
    def width(self):
        return abs(self.x2 - self.x1)

    @property
    def height(self):
        return abs(self.y2 - self.y1)

    @property
    def area(self):
        return self.width * self.height


class FloorCV(ABC):
    @staticmethod
    def make_2d_list(lst: list, n: int) -> list:
        return [lst[i:i + n] for i in range(0, len(lst), n)]

    @staticmethod
    def ndarray_to_bytes(image: np.ndarray, file_format: str = '.png') -> bytes:
        success, encoded_image = cv.imencode(file_format, image)
        if not success:
            raise ValueError("Image encoding failed.")
        return encoded_image.tobytes()

    @staticmethod
    def subtract_images(img1: np.ndarray, img2: np.ndarray) -> np.ndarray:
        return cv.subtract(img1, img2)

    @staticmethod
    def get_column_widths(vertical_lines: np.ndarray) -> List[float]:
        line_strings = [LineString([(x1, y1), (x2, y2)]) for x1, y1, x2, y2 in vertical_lines]
        column_widths = [
            line_strings[i].distance(line_strings[i + 1])
            for i in range(len(line_strings) - 1)
        ]
        return column_widths

    @staticmethod
    def read_grayscale_img(filename: str) -> np.ndarray:
        return cv.imread(filename, cv.IMREAD_GRAYSCALE)

    @staticmethod
    def read_grayscale_img_from_bytes(data) -> np.ndarray:
        return cv.imdecode(data, cv.IMREAD_GRAYSCALE)

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
    def log_image(root_dir: Path, img: np.ndarray, title: str) -> None:
        unique_id = uuid.uuid4()
        output_path = root_dir / 'outputs' / f'{title}_{unique_id}.jpg'
        cv.imwrite(str(output_path), img)

    @staticmethod
    def get_table_corners(intersections: List[Point]) -> List:
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
        corners = [[point.x, point.y] for point in corner_list]
        return corners

    @staticmethod
    def create_rectangular_mask(img: np.ndarray, corners: List) -> np.ndarray:
        mask_image = np.zeros_like(img)
        np_corners = np.int32(corners)
        cv.fillConvexPoly(mask_image, np_corners, [255])
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
    def __extend_line_from_slope(x1: float, y1: float, slope: float, width: float, height: float) -> np.ndarray:
        points = []

        # Calculate intersection with the top boundary (y = 0)
        try:
            x_top = x1 + (0 - y1) / slope
            if 0 <= x_top <= width:
                points.append((x_top, 0))
        except ZeroDivisionError:
            pass

        # Calculate intersection with the bottom boundary (y = height)
        try:
            x_bottom = x1 + (height - y1) / slope
            if 0 <= x_bottom <= width:
                points.append((x_bottom, height))
        except ZeroDivisionError:
            pass

        # Calculate intersection with the left boundary (x = 0)
        y_left = y1 + slope * (0 - x1)
        if 0 <= y_left <= height:
            points.append((0, y_left))

        # Calculate intersection with the right boundary (x = width)
        y_right = y1 + slope * (width - x1)
        if 0 <= y_right <= height:
            points.append((width, y_right))

        # If we have exactly 2 valid points, return them
        if len(points) == 2:
            return np.array([points[0][0], points[0][1], points[1][0], points[1][1]])
        else:
            raise ValueError("Could not find exactly two boundary intersections.")

    @staticmethod
    def extend_line(x1: float, y1: float, x2: float, y2: float, img: np.ndarray) -> np.ndarray:
        height, width = img[:2]
        slope = FloorCV.__get_slope(x1, x2, y1, y2)
        return FloorCV.__extend_line_from_slope(x1, y1, slope, width, height)

    @staticmethod
    def find_cells(imh: np.ndarray) -> List[Cell]:
        kernel = np.ones((3, 3), np.uint8)
        imh = cv.dilate(imh, kernel, iterations=1)
        imh = cv.Canny(imh, 0, 0)
        contours, _ = cv.findContours(imh, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
        cells = []

        for contour in contours:
            x, y, width, height = cv.boundingRect(contour)
            x2 = x + width
            y2 = y + height
            if width > 12 and height > 12:
                cells.append(Cell(x1=x, y1=y, x2=x2, y2=y2))
        cells.reverse()
        return cells

    @staticmethod
    def export_cells(root_dir: Path, cells: List[Cell], img: np.ndarray) -> None:
        annotated_image = img.copy()
        for idx, cell in enumerate(cells):
            top_left = (cell.x1, cell.y1)
            bottom_right = (cell.x2, cell.y2)

            color = (0, 0, 255)  # BGR format: red color
            thickness = 2  # Thickness of the rectangle border
            cv.rectangle(annotated_image, top_left, bottom_right, color, thickness)

            center_x = (cell.x1 + cell.x2) // 2
            center_y = (cell.y1 + cell.y2) // 2

            font = cv.FONT_HERSHEY_SIMPLEX
            font_scale = 0.7
            text_color = (0, 0, 255)  # Red color
            text_thickness = 2
            cv.putText(annotated_image, str(idx + 1), (center_x - 10, center_y + 10), font, font_scale, text_color, text_thickness)
        FloorCV.log_image(root_dir, annotated_image, 'annotated_image')

    @staticmethod
    def get_dst_corners(corners: List) -> List:
        """
        Expects corner spots of a distorted rect and deduces the new corner spots for a straightened rect.
        """
        x_min = float('inf')
        y_min = float('inf')
        x_max = float('-inf')
        y_max = float('-inf')
        for corner in corners:
            corner_x = corner[0]
            corner_y = corner[1]
            if corner_x < x_min:
                x_min = corner_x
            if corner_y < y_min:
                y_min = corner_y
            if corner_x > x_max:
                x_max = corner_x
            if corner_y > y_max:
                y_max = corner_y
        return [
            [x_min, y_min],
            [x_max, y_min],
            [x_max, y_max],
            [x_min, y_max],
        ]

    @staticmethod
    def straighten_table(img: np.ndarray, lines: List, corners: List) -> Tuple:
        src_corners = np.float32(corners)
        new_corners = FloorCV.get_dst_corners(corners)
        dst_corners = np.float32(new_corners)
        perspective_transform = cv.getPerspectiveTransform(src_corners, dst_corners)

        transformed_lines = []
        for line in lines:
            points = np.float32(line).reshape(-1, 1, 2)
            transformed_points = cv.perspectiveTransform(points, perspective_transform)
            transformed_points = transformed_points.reshape(4)
            transformed_lines.append(transformed_points)
        FloorCV.extend_all_lines(img, transformed_lines)
        warped_image = FloorCV.warp_image(img, perspective_transform)
        return warped_image, transformed_lines, new_corners, perspective_transform

    @staticmethod
    def warp_image(img, perspective_transform) -> cv.typing.MatLike:
        return cv.warpPerspective(img, perspective_transform, (img.shape[1], img.shape[0]))

    @staticmethod
    def get_structuring_elements(img: np.ndarray) -> np.ndarray:
        kernel = cv.getStructuringElement(cv.MORPH_RECT, (3, 3))
        dilated_img = cv.dilate(img, kernel, iterations=1)
        horizontal_kernel = cv.getStructuringElement(cv.MORPH_RECT, (20, 1))
        vertical_kernel = cv.getStructuringElement(cv.MORPH_RECT, (1, 15))
        horizontal_lines = cv.morphologyEx(img, cv.MORPH_OPEN, horizontal_kernel, iterations=2)
        vertical_lines = cv.morphologyEx(dilated_img, cv.MORPH_OPEN, vertical_kernel, iterations=2)
        return cv.add(horizontal_lines, vertical_lines)

    @staticmethod
    def get_all_lines(img: np.ndarray) -> List:
        lines = cv.HoughLinesP(image=img, rho=1, theta=np.pi / 180, threshold=300, minLineLength=30,
                               maxLineGap=200)
        lines = np.squeeze(lines)
        return list(lines)

    @staticmethod
    def extend_all_lines(img: np.ndarray, lines: List) -> None:
        base_img = np.zeros_like(img)
        if lines is None or len(lines) < 2:
            pass
        for i in range(len(lines)):
            x1, y1, x2, y2 = lines[i]
            lines[i] = FloorCV.extend_line(x1, y1, x2, y2, base_img.shape)

    @staticmethod
    def straighten_horizontal_lines(horizontal_lines: np.ndarray) -> np.ndarray:
        straightened_lines = horizontal_lines.copy()
        for line in straightened_lines:
            x1, y1, x2, y2 = line
            avg_y = (y1 + y2) / 2
            line[1] = avg_y
            line[3] = avg_y

        return straightened_lines

    @staticmethod
    def straighten_vertical_lines(vertical_lines: np.ndarray) -> np.ndarray:
        straightened_lines = vertical_lines.copy()
        for line in straightened_lines:
            x1, y1, x2, y2 = line
            avg_x = (x1 + x2) / 2
            line[0] = avg_x
            line[2] = avg_x

        return straightened_lines

    @staticmethod
    def sort_vertical_lines_by_x(vertical_lines: np.ndarray) -> np.ndarray:
        return vertical_lines[vertical_lines[:, 0].argsort()]

    @staticmethod
    def sort_horizontal_lines_by_y(horizontal_lines: np.ndarray) -> np.ndarray:
        return horizontal_lines[horizontal_lines[:, 1].argsort()]

    @staticmethod
    def __table_height(sorted_horizontal_lines: np.ndarray):
        first_y = sorted_horizontal_lines[0, 1]
        last_y = sorted_horizontal_lines[-1, 1]
        return last_y-first_y

    @staticmethod
    def average_vertical_distance(sorted_horizontal_lines: np.ndarray) -> float:
        if len(sorted_horizontal_lines) < 2:
            return 0.0
        return float((FloorCV.__table_height(sorted_horizontal_lines)) / (len(sorted_horizontal_lines) - 1))

    @staticmethod
    def adjust_horizontal_lines_by_avg_vertical_distance(avg_distance: float,
                                                         sorted_horizontal_lines: np.ndarray) -> np.ndarray:
        adjusted_lines = sorted_horizontal_lines.copy()
        if len(sorted_horizontal_lines) < 2:
            return adjusted_lines

        for i in range(1, len(adjusted_lines) - 1):
            adjusted_lines[i, 1] = adjusted_lines[0, 1] + avg_distance * i
            adjusted_lines[i, 3] = adjusted_lines[0, 3] + avg_distance * i

        return adjusted_lines

    @staticmethod
    def add_lines_to_zeros_like_img(img: np.ndarray, lines: List) -> np.ndarray:
        img_all_lines = np.zeros_like(img)
        FloorCV.add_lines_to_img(img_all_lines, lines)
        return img_all_lines

    @staticmethod
    def add_lines_to_img(img: np.ndarray, lines: List) -> None:
        if lines is None or len(lines) < 2:
            pass
        for line in lines:
            x1, y1, x2, y2 = line
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            cv.line(img, [x1, y1], [x2, y2], [255], 1)

    @staticmethod
    def __get_abs_slope(x1, x2, y1, y2):
        return abs(FloorCV.__get_slope(x1, x2, y1, y2))

    @staticmethod
    def __get_slope(x1, x2, y1, y2):
        dx = x2 - x1
        dy = y2 - y1
        if dx == 0:
            return float('inf')
        elif dy == 0:
            return 0.0
        else:
            slope = dy / dx
            return slope

    @staticmethod
    def filter_out_close_lines(lines: np.ndarray, threshold: float = 25.0) -> Tuple[np.ndarray, np.ndarray]:
        shapely_lines = [LineString([(x1, y1), (x2, y2)]) for x1, y1, x2, y2 in lines]

        def is_horizontal(line: LineString, threshold=.2):
            abs_slope = FloorCV.__get_abs_slope(line.coords[0][0], line.coords[1][0], line.coords[0][1],
                                                line.coords[1][1])
            return abs_slope <= threshold

        def is_vertical(line: LineString):
            return is_horizontal(
                line=LineString([(-line.coords[0][1], line.coords[0][0]), (-line.coords[1][1], line.coords[1][0])]))

        def filter_lines_by_orientation(lines: List[LineString], is_horizontal: bool):
            filtered = []
            for i, line1 in enumerate(lines):
                keep_line = True
                line1_abs_slope = FloorCV.__get_abs_slope(line1.coords[0][0], line1.coords[1][0], line1.coords[0][1],
                                                          line1.coords[1][1])
                for j, line2 in enumerate(filtered):
                    if i == j:
                        continue
                    if line1.distance(line2) < threshold:
                        line2_abs_slope = FloorCV.__get_abs_slope(line2.coords[0][0], line2.coords[1][0],
                                                                  line2.coords[0][1],
                                                                  line2.coords[1][1])
                        if (is_horizontal and line1_abs_slope < line2_abs_slope) or (
                                not is_horizontal and line1_abs_slope > line2_abs_slope):
                            filtered[j] = line1
                        keep_line = False
                        break
                if keep_line:
                    filtered.append(line1)

            return filtered

        remaining_lines = shapely_lines.copy()
        horizontal_lines = []
        for i in range(len(shapely_lines) - 1, -1, -1):
            line = shapely_lines[i]
            if is_horizontal(line):
                horizontal_lines.append(line)
                remaining_lines.pop(i)
        vertical_lines = [line for line in remaining_lines if is_vertical(line)]

        filtered_horizontal = filter_lines_by_orientation(horizontal_lines, is_horizontal=True)
        filtered_vertical = filter_lines_by_orientation(vertical_lines, is_horizontal=False)
        filtered_horizontal = np.array(
            [[line.coords[0][0], line.coords[0][1], line.coords[1][0], line.coords[1][1]] for line in
             filtered_horizontal],
            dtype=np.int32)
        filtered_vertical = np.array(
            [[line.coords[0][0], line.coords[0][1], line.coords[1][0], line.coords[1][1]] for line in
             filtered_vertical],
            dtype=np.int32)
        return filtered_horizontal, filtered_vertical

    @staticmethod
    def add_lines_around_table(corners: List, lines: List):
        lines_around_table = [
            [corners[0][0], corners[0][1], corners[1][0], corners[1][1]],  # top-left to top-right
            [corners[1][0], corners[1][1], corners[2][0], corners[2][1]],  # top-right to bottom-right
            [corners[0][0], corners[0][1], corners[3][0], corners[3][1]],  # top-left to bottom-left
            [corners[3][0], corners[3][1], corners[2][0], corners[2][1]],  # bottom-left to bottom-right
        ]
        lines_around_table = np.float32(lines_around_table)
        lines.extend(lines_around_table)

    @staticmethod
    def get_all_intersections(img: np.ndarray, lines: List) -> List[Point]:
        intersections = []
        img_height, img_width = img.shape[:2]
        image_box = box(0, 0, img_width, img_height)

        lines_list = [line for line in lines]
        lines_length = len(lines_list)
        for i in range(lines_length - 1, -1, -1):
            x0_1, y0_1, x0_2, y0_2 = lines_list[i]
            line_str_a = LineString([(x0_1, y0_1), (x0_2, y0_2)])
            tmp_points = []
            for j in range(len(lines_list)):
                if i == j:
                    continue
                x1_1, y1_1, x1_2, y1_2 = lines_list[j]
                line_str_b = LineString([(x1_1, y1_1), (x1_2, y1_2)])
                point = line_str_a.intersection(line_str_b)
                if point is None or isinstance(point, LineString):
                    continue
                if not image_box.contains(point):
                    continue
                tmp_points.append(point)
            for point in tmp_points:
                intersections.append(point)
        return intersections
