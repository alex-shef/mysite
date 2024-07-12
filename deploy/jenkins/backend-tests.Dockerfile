# backend-tests.Dockerfile
FROM jenkins/inbound-agent:latest-jdk11

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    libpq-dev && \
    python3 -m venv /opt/venv && \
    rm -rf /var/lib/apt/lists/*

COPY ../../test_requirements.txt /tmp/
RUN /opt/venv/bin/pip install --no-cache-dir -r /tmp/test_requirements.txt

ENV PATH="/opt/venv/bin:$PATH"

USER jenkins
