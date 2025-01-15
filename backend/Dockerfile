# Base Python image
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Generate the de_DE.UTF-8 locale and apply it
RUN localedef -i de_DE -f UTF-8 de_DE.UTF-8

# Set the locale to de_DE.UTF-8
ENV LANG=de_DE.UTF-8
ENV LC_ALL=de_DE.UTF-8
ENV PYTHONUNBUFFERED=1

# Create a non-root user
RUN groupadd -r appuser && useradd --no-log-init -r -g appuser appuser

# Set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && pip install --no-cache-dir gunicorn

# Copy application code
COPY . .


# Expose application port
EXPOSE 8080

# Add startup script to dynamically set GOOGLE_APPLICATION_CREDENTIALS
#COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

# Switch to non-root user
USER appuser

# Set default command
CMD ["sh", "/app/startup.sh"]
