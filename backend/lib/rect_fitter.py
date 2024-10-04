from typing import List, Optional

from lib.floor_cv import Cell


def intersection_area(cell1: Cell, cell2: Cell) -> int:
    intersect_x_min = max(cell1.x1, cell2.x1)
    intersect_y_min = max(cell1.y1, cell2.y1)
    intersect_x_max = min(cell1.x2, cell2.x2)
    intersect_y_max = min(cell1.y2, cell2.y2)

    if intersect_x_min < intersect_x_max and intersect_y_min < intersect_y_max:
        intersect_width = intersect_x_max - intersect_x_min
        intersect_height = intersect_y_max - intersect_y_min
        return intersect_width * intersect_height
    else:
        return 0


def find_best_fit(rectangles: List[Cell], rect_to_check: Cell) -> Optional[int]:
    best_i = None
    best_coverage = 0

    rect_to_check_area = rect_to_check.area

    for i, rect in enumerate(rectangles):
        intersect_area = intersection_area(rect_to_check, rect)
        coverage = intersect_area / rect_to_check_area

        if coverage > best_coverage:
            best_coverage = coverage
            best_i = i

        if coverage == 1:
            return i

    return best_i


# def find_best_fit(rectangles, rect_to_check):
#     best_rectangle = None
#     best_coverage = 0
#
#     rect_to_check_area = area(rect_to_check)
#
#     i = None
#     for i, rect in enumerate(rectangles):
#         intersect_area = intersection_area(rect_to_check, rect)
#         coverage = intersect_area / rect_to_check_area
#
#         if coverage > best_coverage:
#             best_coverage = coverage
#             best_rectangle = rect
#
#         if coverage == 1:
#             return i, rect
#
#     return i, best_rectangle
