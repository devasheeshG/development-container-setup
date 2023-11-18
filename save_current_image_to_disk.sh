#!/bin/bash

current_datetime=$(date)

current_date=$(date +"%Y_%m_%d")
current_time=$(date +"%H_%M")

echo "Saving current image at ${current_datetime}"
docker save -o ubuntu22.04-devel-cuda12.1-cudnn8_${current_date}_${current_time}.tar ubuntu22.04-devel-cuda12.1-cudnn8:latest