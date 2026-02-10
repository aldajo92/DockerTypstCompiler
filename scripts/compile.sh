#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config_docker.sh

# Check if article parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <article_directory>"
    echo "Example: $0 your_project"
    echo "This will compile the Typst files in ws_typst/<article_directory>/"
    exit 1
fi

ARTICLE_DIR="$1"

# Handle both ws_typst/ARTICLE_DIR and just ARTICLE_DIR formats
if [[ "$ARTICLE_DIR" == ws_typst/* ]]; then
    # Remove ws_typst/ prefix if present
    ARTICLE_DIR="${ARTICLE_DIR#ws_typst/}"
fi

# Check if the article directory exists
if [ ! -d "${PROJECT_ROOT}/ws_typst/${ARTICLE_DIR}" ]; then
    echo "Error: Directory 'ws_typst/${ARTICLE_DIR}' does not exist"
    exit 1
fi

echo "🚀 Compiling Typst files in ws_typst/${ARTICLE_DIR}/"

docker run --rm \
    --volume ${PROJECT_ROOT}/ws_typst:/home/dockeruser/ws_typst \
    --volume ${PROJECT_ROOT}/templates:/home/dockeruser/templates \
    --network ${DOCKER_NETWORK} \
    --dns=8.8.8.8 \
    ${DOCKER_IMAGE_NAME} \
    "${ARTICLE_DIR}"