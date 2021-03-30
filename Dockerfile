FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG PHOENIX_VERSION="5.5c"
ARG AMD_SITE_URL="https://drivers.amd.com/drivers/linux/"
ARG AMDGPU_VERSION="amdgpu-pro-20.45-1188099-ubuntu-20.04"

ENV TZ America/Caracas
ENV POOL "stratum1+tcp://us-east.ezil.me:5555"
ENV WALLET "0xcd14DeA4649927ff0c3a3Fd2B8d5D1858079DA15.zil1epm0936hxwuf790fztzuy8ztmm72ah20hh57xs"
ENV PASSWORD "x"
ENV WORKER "PhoenixMiner"
ENV EXTRA_ARGS ""

LABEL Name=phoenix-miner
LABEL Version=0.1

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    ca-certificates \
    tzdata \
    curl \
    xz-utils \
    libpci3

# COPY amdgpu-pro-20.45-1188099-ubuntu-20.04.tar.xz .
RUN curl --referer ${AMD_SITE_URL} -O ${AMD_SITE_URL}${AMDGPU_VERSION}.tar.xz \
    && tar -Jxvf ${AMDGPU_VERSION}.tar.xz \
    && ${AMDGPU_VERSION}/amdgpu-install -y --opencl=legacy --headless --no-dkms --no-32 \
    && rm -rf amdgpu-pro-* /var/opt/amdgpu-pro-local /var/lib/apt/lists/*

RUN curl -OL "https://github.com/PhoenixMinerDevTeam/PhoenixMiner/releases/download/${PHOENIX_VERSION}/PhoenixMiner_${PHOENIX_VERSION}_Linux.tar.gz" \
    && tar -xzvf PhoenixMiner_${PHOENIX_VERSION}_Linux.tar.gz \
    && mv PhoenixMiner_${PHOENIX_VERSION}_Linux/PhoenixMiner phoenix-miner \
    && rm -rf PhoenixMiner*

ENTRYPOINT ./phoenix-miner -pool ${POOL} -wal ${WALLET} -pass ${PASSWORD} -worker ${WORKER} ${EXTRA_ARGS}
