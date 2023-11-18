#!/bin/bash

current_datetime=$(date)

read -p "Enter commit message: " commit_message

echo "Committing current image at ${current_datetime} with message: ${commit_message}"
docker commit -a "Devasheesh Mishra" -m "${commit_message}" ubuntu22.04-devel-cuda12.1-cudnn8 ubuntu22.04-devel-cuda12.1-cudnn8:latest