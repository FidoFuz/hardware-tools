FROM debian:stable-slim

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

WORKDIR /tools

CMD ["sleep", "infinity"]