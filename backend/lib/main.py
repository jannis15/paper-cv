from fastapi import FastAPI, UploadFile
from lib.floor_cv_controller import FloorCvController
import numpy as np
import os

app = FastAPI()


@app.post('/scan')
async def scan_file(file: UploadFile):
    file_bytes = await file.read()
    np_arr = np.frombuffer(file_bytes, np.uint8)
    file_path = os.path.join('outputs', 'scan.jpg')
    with open(file_path, 'wb') as f:
        f.write(file_bytes)
    FloorCvController.scan_file(np_arr)


if __name__ == '__main__':
    import uvicorn

    uvicorn.run(app, host='0.0.0.0', port=443)
