FROM fedora:42
RUN dnf install -y \
    findutils \
    git \
    gzip \
    libxml2 \
    lz4 \
    tar \
    tree \
    unzip \
    && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN mkdir -p /musicxml/patches
COPY ./musicxml /musicxml

LABEL "org.opencontainers.image.source"="https://github.com/webern/xmlvalidator"
