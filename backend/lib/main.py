from fastapi import FastAPI, UploadFile
from lib.floor_cv_controller import FloorCvController
from dotenv import load_dotenv
from google.cloud import vision

load_dotenv()
app = FastAPI()
client = vision.ImageAnnotatorClient()


@app.post('/scan')
async def scan_file(file: UploadFile):
    file_bytes = await file.read()
    import os
    file_path = os.path.join('outputs', 'scan.jpg')
    with open(file_path, 'wb') as f:
        f.write(file_bytes)
    FloorCvController.scan_file(client=client, file_bytes=file_bytes)


if __name__ == '__main__':
    import uvicorn

    uvicorn.run(app, host='0.0.0.0', port=443)
