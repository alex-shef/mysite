# app-builder.Dockerfile
FROM jenkins/inbound-agent:latest-jdk11

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    podman \
    uidmap \
    libcap2-bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN chmod u-s /usr/bin/new[gu]idmap && \
    setcap cap_setuid+eip /usr/bin/newuidmap && \
    setcap cap_setgid+eip /usr/bin/newgidmap

USER jenkins
