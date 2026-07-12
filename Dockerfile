FROM debian:stable-slim

ARG GIT_COMMIT=unknown
ARG BUILD_DATE=unknown
ARG IMAGE_NAME=hardware-tools

LABEL org.opencontainers.image.title="hardware-tools"
LABEL org.opencontainers.image.description="Portable hardware diagnostics and inventory toolkit"
LABEL org.opencontainers.image.source="https://github.com/FidoFuz/hardware-tools"
LABEL org.opencontainers.image.revision=$GIT_COMMIT
LABEL org.opencontainers.image.created=$BUILD_DATE

ENV GIT_COMMIT=$GIT_COMMIT \
    BUILD_DATE=$BUILD_DATE \
    IMAGE_NAME=$IMAGE_NAME
	
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        dmidecode \
        ethtool \
        ipmitool \
        jq \
        lshw \
        nvme-cli \
        pciutils \
        smartmontools \
        usbutils \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

WORKDIR /tools

CMD ["sleep", "infinity"]