from pydantic import BaseModel
from typing import List


class ScanProperties(BaseModel):
    column_widths: List[float]
    rows: int
    avg_row_height: float
    cell_texts: List[List[str]]
