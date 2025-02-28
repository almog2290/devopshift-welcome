# Dockerfile
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}

WORKDIR /app

# Install dependencies
RUN pip install faker

# Copy the Python script
COPY app.py .

# Command to run the Python script
CMD ["python", "app.py"]