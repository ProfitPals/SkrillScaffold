# Use Python 3.9 slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose the Flask service port
EXPOSE {{cookiecutter.port}}

# Start the service using Gunicorn
CMD ["gunicorn", "-c", "gunicorn.conf.py", "app:app"]
