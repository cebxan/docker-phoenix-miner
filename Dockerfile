FROM ubuntu:20.04

ARG PHOENIX_VERSION="5.5c"
ENV POOL_ADDRESS "stratum1+tcp://us-east.ezil.me:5555"
ENV WALLET_ADDRESS "0xcd14DeA4649927ff0c3a3Fd2B8d5D1858079DA15.zil1epm0936hxwuf790fztzuy8ztmm72ah20hh57xs"
ENV PASSWORD "x"
ENV WORKER "PhoenixMiner"
ENV TZ America/Caracas
ENV EXTRA_ARGS ""

LABEL Name=phoenix-miner
LABEL Version=0.0.1

RUN apt-get -y update && apt-get install -y \
    apt-utils \
    tzdata \
    curl \
    xz-utils \
    libpci3 \
    && rm -rf /var/lib/apt/lists/*

#RUN curl --referer https://drivers.amd.com/drivers/linux/ -O https://drivers.amd.com/drivers/linux/amdgpu-pro-20.45-1188099-ubuntu-20.04.tar.xz
COPY amdgpu-pro-20.45-1188099-ubuntu-20.04.tar.xz .
RUN tar -Jxvf amdgpu-pro-20.45-1188099-ubuntu-20.04.tar.xz
WORKDIR /amdgpu-pro-20.45-1188099-ubuntu-20.04
RUN ./amdgpu-install -y --opencl=legacy --headless --no-dkms --no-32 \
    && rm -rf amdgpu-pro-*

RUN curl -OL "https://github.com/PhoenixMinerDevTeam/PhoenixMiner/releases/download/${PHOENIX_VERSION}/PhoenixMiner_${PHOENIX_VERSION}_Linux.tar.gz" \
    && tar -xzvf PhoenixMiner_${PHOENIX_VERSION}_Linux.tar.gz \
    && mv PhoenixMiner_${PHOENIX_VERSION}_Linux/PhoenixMiner phoenix-miner \
    && rm -rf PhoenixMiner*

ENTRYPOINT ./phoenix-miner -pool ${POOL_ADDRESS} -wal ${WALLET_ADDRESS}.${PASSWORD} -worker ${WORKER} ${EXTRA_ARGS}
