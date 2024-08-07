docker run -it --rm \
    --name='ubuntu22.04-devel-cuda12.1-cudnn8' \
    --net='br0' \
    --ip='192.168.0.253' \
    --gpus all \
    --entrypoint /bin/bash \
    --privileged=true \
    -e TZ="Asia/Calcutta" \
    -e HOST_OS="Unraid" \
    -e HOST_HOSTNAME="SERVER" \
    -e HOST_CONTAINERNAME="Ubuntu22.04-devel-cuda12.1-cudnn8" \
    -e 'UDP_PORT_80'='80' \
    -l net.unraid.docker.managed=dockerman \
    -l net.unraid.docker.icon='https://brandslogos.com/wp-content/uploads/images/large/ubuntu-logo.png' \
    -v '/mnt/nvme/coding/':'/mnt/nvme':'rw' \
    -v '/mnt/user/coding_archive/':'/mnt/hdd':'rw' \
    --hostname devel-container 'ubuntu22.04-devel-cuda12.1-cudnn8:latest' \
    # -c "code tunnel --accept-server-license-terms && service ssh start"
    -c "service ssh start"
