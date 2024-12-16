FROM python:3.12-slim
ENV PYTHONUNBUFFERED=1
RUN groupadd -r appuser && useradd --no-log-init -r -g appuser appuser
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir gunicorn
COPY . .
USER appuser
EXPOSE 8080
CMD ["sh", "-c", "gunicorn -k uvicorn.workers.UvicornWorker lib.main:app --bind 0.0.0.0:${PORT:-8080} --workers 2"]
