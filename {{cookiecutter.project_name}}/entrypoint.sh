#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run database migrations (if applicable)
# echo "Running migrations..."
# flask db upgrade

# Start Gunicorn server
echo "Starting Gunicorn server..."
gunicorn -c gunicorn.conf.py app:app