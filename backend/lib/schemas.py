from pydantic import BaseModel
from typing import List


class ScanProperties(BaseModel):
    column_widths_cm: List[float]
    rows: int
    avg_row_height_cm: float
    cell_texts: List[List[str]]

class Selection(BaseModel):
    x1: float
    y1: float
    x2: float
    y2: float