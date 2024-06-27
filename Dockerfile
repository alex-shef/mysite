FROM python:3.8

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /mysite

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
