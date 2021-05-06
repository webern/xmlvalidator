FROM fedora:34
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
COPY ./v3.0-use-local-schema-location.patch \
     ./v3.1-use-local-schema-location.patch \
     ./v4.0-use-local-schema-location.patch \
     /musicxml/patches/

RUN git config --global user.email "xmlvalidator@example.com" && \
    git config --global user.name "XML Validator" && \
    git clone https://github.com/w3c/musicxml.git /musicxml/src && \
    cd /musicxml/src && \
    git checkout -b v4.0-patch && \
    git apply ../patches/v4.0-use-local-schema-location.patch && \
    git commit --all -m'patch schema location' && \
    mkdir /musicxml/v4.0 && \
    cp ./schema/musicxml.xsd /musicxml/v4.0/musicxml.xsd && \
    cp ./schema/xml.xsd /musicxml/v4.0/xml.xsd && \
    cp ./schema/xlink.xsd /musicxml/v4.0/xlink.xsd \
    && \
    git checkout gh-pages && git checkout v3.1 && git checkout -b v3.1-patch && \
    git apply ../patches/v3.1-use-local-schema-location.patch && \
    git commit --all -m'patch schema location' && \
    mkdir /musicxml/v3.1 && \
    cp ./schema/musicxml.xsd /musicxml/v3.1/musicxml.xsd && \
    cp ./schema/xml.xsd /musicxml/v3.1/xml.xsd && \
    cp ./schema/xlink.xsd /musicxml/v3.1/xlink.xsd \
    && \
    git checkout gh-pages && git checkout v3.0 && git checkout -b v3.0-patch && \
    git apply ../patches/v3.0-use-local-schema-location.patch && \
    git commit --all -m'patch schema location' && \
    mkdir /musicxml/v3.0 && \
    cp ./schema/musicxml.xsd /musicxml/v3.0/musicxml.xsd && \
    cp ./schema/xml.xsd /musicxml/v3.0/xml.xsd && \
    cp ./schema/xlink.xsd /musicxml/v3.0/xlink.xsd \
    && \
    git checkout gh-pages

LABEL "org.opencontainers.image.source"="https://github.com/webern/xmlvalidator"
