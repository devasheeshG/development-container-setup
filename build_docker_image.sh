#!/bin/bash

# Load environment variables from .env file
# export $(cat .env | xargs)

# Build the Docker image with --build-arg
docker build . \
  # --build-arg ROOT_PASSWORD=${ROOT_PASSWORD} \
  # --build-arg DEVASHEESH_PASSWORD=${DEVASHEESH_PASSWORD} \
  -t ubuntu22.04-devel-cuda12.1-cudnn8:latest .
