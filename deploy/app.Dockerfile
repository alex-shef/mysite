# app.Dockerfile
FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ../requirements.txt /app/
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt && \
    /app/venv/bin/pip install gunicorn

COPY .. /app/

WORKDIR /app

ENV PATH="/app/venv/bin:$PATH"
