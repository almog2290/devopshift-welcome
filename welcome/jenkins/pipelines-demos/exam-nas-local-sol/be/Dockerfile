# Dockerfile for Backend Service
FROM python:3.12 AS builder

WORKDIR /build

# Copy requirements and install dependencies
COPY requirements.txt .

# Create wheels directory
RUN mkdir -p /wheels
# Build wheels for all dependencies
RUN pip wheel --no-cache-dir --wheel-dir=/wheels -r requirements.txt

# Final stage
FROM python:3.12-slim AS application

WORKDIR /app

# Copy wheels and install from them
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir --no-index --find-links=/wheels/ /wheels/* \
    && rm -rf /wheels && rm -rf /root/.cache/pip

COPY ./src .

EXPOSE 5001

CMD ["python", "mainbe.py"]