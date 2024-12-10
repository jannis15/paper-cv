from fastapi import FastAPI, UploadFile, Request
from lib.floor_cv_controller import FloorCvController
from dotenv import load_dotenv
from google.cloud import vision
from fastapi.middleware.cors import CORSMiddleware
from slowapi import Limiter
from slowapi.util import get_remote_address

load_dotenv()
app = FastAPI()
limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter
client = vision.ImageAnnotatorClient()

origins = [
    "http://localhost:53767",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post('/scan')
@limiter.limit('6/minute')
async def scan_file(request: Request, file: UploadFile):
    file_bytes = await file.read()
    import os
    file_path = os.path.join('outputs', 'scan.jpg')
    with open(file_path, 'wb') as f:
        f.write(file_bytes)
    properties = FloorCvController.scan_file(client=client, file_bytes=file_bytes)
    return properties


if __name__ == '__main__':
    import uvicorn

    uvicorn.run(app, host='0.0.0.0', port=443)
