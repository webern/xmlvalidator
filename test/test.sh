#!/usr/bin/env bash
set -eou pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
DOCKERFILE="${ROOT_DIR}/Dockerfile"
IMAGE='ghcr.io/webern/xmlvalidator:testing'
echo "building docker image"

docker build \
  -f "${DOCKERFILE}" \
  -t "${IMAGE}" \
  "${ROOT_DIR}"

echo "testing with musicxml 3.0"
docker run \
  --rm \
  -v "${SCRIPT_DIR}/musicxml-file.xml:/xmlfiles/musicxml-file.xml" \
  "${IMAGE}" \
  xmllint --noout --nonet --schema /musicxml/v3.0/musicxml.xsd /xmlfiles/musicxml-file.xml

echo "testing with musicxml 3.1"
docker run \
  --rm \
  -v "${SCRIPT_DIR}/musicxml-file.xml:/xmlfiles/musicxml-file.xml" \
  "${IMAGE}" \
  xmllint --noout --nonet --schema /musicxml/v3.1/musicxml.xsd /xmlfiles/musicxml-file.xml

echo "testing with musicxml 4.0"
docker run \
  --rm \
  -v "${SCRIPT_DIR}/musicxml-file.xml:/xmlfiles/musicxml-file.xml" \
  "${IMAGE}" \
  xmllint --noout --nonet --schema /musicxml/v4.0/musicxml.xsd /xmlfiles/musicxml-file.xml
