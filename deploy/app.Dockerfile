FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY ../requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt
RUN pip install gunicorn

COPY .. /app/
WORKDIR /app
