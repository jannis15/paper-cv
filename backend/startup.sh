#!/bin/sh

# Check if CREDENTIALS is set and set GOOGLE_APPLICATION_CREDENTIALS accordingly
if [ -n "$CREDENTIALS" ]; then
  export GOOGLE_APPLICATION_CREDENTIALS="$CREDENTIALS"
  echo "GOOGLE_APPLICATION_CREDENTIALS set to: $GOOGLE_APPLICATION_CREDENTIALS"
else
  echo "Warning: CREDENTIALS environment variable is not set."
fi

# Start the application
exec gunicorn -k uvicorn.workers.UvicornWorker lib.main:app --bind 0.0.0.0:${PORT:-8080} --workers 2
