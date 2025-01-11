from pydantic import BaseModel
from typing import List


class ScanResult(BaseModel):
    column_widths_cm: List[float]
    rows: int
    avg_row_height_cm: float
    table_x_cm: float
    table_y_cm: float
    img_width_px: float
    img_height_px: float
    ref_uuid: str
    cell_texts: List[List[str]]


class Selection(BaseModel):
    x1: float
    y1: float
    x2: float
    y2: float


class ScanProperties(BaseModel):
    selection: Selection
    ref_uuid: str
    template_no: int
