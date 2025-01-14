import json
from fastapi import FastAPI, UploadFile, Request, HTTPException, Depends
from fastapi.params import Form, File
from fastapi.responses import JSONResponse, StreamingResponse
from lib.floor_cv_controller import FloorCvController
from google.cloud import vision
from fastapi.middleware.cors import CORSMiddleware
from slowapi import Limiter
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded
from PIL import Image
import io
import os
from lib.schemas import Selection, ScanProperties, ScanRecalculation

app = FastAPI()
limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter
vision_client = vision.ImageAnnotatorClient()

MAX_FILE_SIZE_MB = 10
MAX_FILE_SIZE_BYTES = MAX_FILE_SIZE_MB * 1024 * 1024


async def validate_file(request: Request, file: UploadFile = Depends()) -> bytes:
    content_length = request.headers.get('Content-Length')

    if content_length:
        content_length = int(content_length)
        if content_length > MAX_FILE_SIZE_BYTES:
            raise HTTPException(status_code=400, detail="File size exceeds the 10 MB limit")

    if not file.content_type.startswith('image/'):
        raise HTTPException(status_code=400, detail="File is not an image")

    file_bytes = await file.read()
    try:
        image = Image.open(io.BytesIO(file_bytes))
        image.verify()
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid image file")

    return file_bytes


origins = [
    "http://localhost:53767",
    "https://floor-cv.web.app",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.exception_handler(Exception)
async def global_exception_handler(request, exc):
    return JSONResponse(
        status_code=500,
        content={"detail": "An internal server error occurred"},
    )


@app.exception_handler(RateLimitExceeded)
async def rate_limit_error(request, exc):
    return JSONResponse(
        status_code=429,
        content={"detail": "Rate limit exceeded"},
    )


@app.post('/recalculate')
@limiter.limit('6/minute')
async def scan_file(request: Request, scan_recalculation: ScanRecalculation):
    new_cell_texts = FloorCvController.adjust_cell_texts_for_template(template_no=scan_recalculation.template_no,
                                                                      cell_texts=scan_recalculation.cell_texts)
    return ScanRecalculation(cell_texts=new_cell_texts, template_no=scan_recalculation.template_no)


@app.post('/scan')
@limiter.limit('6/minute')
async def scan_file(request: Request, scan_properties: str = Form(...), file: UploadFile = File(...)):
    scan_properties = json.loads(scan_properties)
    scan_properties = ScanProperties(**scan_properties)
    file_bytes = await validate_file(request, file)
    return FloorCvController.scan_file(vision_client=vision_client, file_bytes=file_bytes,
                                       scan_properties=scan_properties,
                                       logging=True)


@app.post('/export-xlsx')
@limiter.limit('6/minute')
async def export_to_excel(request: Request, data_model: ScanRecalculation):
    data = data_model.cell_texts
    output_stream = FloorCvController.insert_data_into_excel(data)
    return StreamingResponse(output_stream,
                             media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")


if __name__ == '__main__':
    import uvicorn

    port = int(os.getenv('PORT', 8080))
    uvicorn.run(app, host="0.0.0.0", port=port)
