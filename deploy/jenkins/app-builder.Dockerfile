# app-builder.Dockerfile
FROM jenkins/inbound-agent:latest-jdk11

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    podman && \
    rm -rf /var/lib/apt/lists/*

USER jenkins
