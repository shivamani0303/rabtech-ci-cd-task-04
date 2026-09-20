# Stage 1: Build dependencies
FROM python:3.12-alpine AS builder

WORKDIR /build

COPY app/requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# Stage 2: Small production image
FROM python:3.12-alpine

# Create non-root user
RUN adduser -D -s /bin/sh appuser

WORKDIR /app

# Copy dependencies from builder
COPY --from=builder /install /usr/local

# Copy application
COPY app/app.py .

# Run as non-root user
USER appuser

EXPOSE 5000

# Container health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

# Start application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]