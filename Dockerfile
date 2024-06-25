FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# Set environment variables
# ARG ROOT_PASSWORD
# ARG DEVASHEESH_PASSWORD
# RUN echo "Root password: ${ROOT_PASSWORD}"
# RUN echo "Devasheesh password: ${DEVASHEESH_PASSWORD}"

# Install apt dependencies
COPY requirements-apt.txt requirements-apt.txt
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install apt-utils -y \
    && xargs apt-get install -y < requirements-apt.txt \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
RUN rm requirements-apt.txt

# Unminimize Ubuntu
RUN yes | unminimize

# Install VSCode Server CLI
# RUN wget https://az764295.vo.msecnd.net/stable/f1b07bd25dfad64b0167beb15359ae573aecd2cc/vscode_cli_alpine_x64_cli.tar.gz && tar -xvf vscode_cli_alpine_x64_cli.tar.gz && mv code /usr/local/bin/code && rm vscode_cli_alpine_x64_cli.tar.gz

# Enable SSH access (for VSCode Remote SSH)
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Set password for the "root" user (from .env file)
# RUN echo 'root:${ROOT_PASSWORD}' | chpasswd
# Create a new user named "devasheesh"
RUN useradd -m -s /bin/bash devasheesh
# Set password for the "devasheesh" user (from .env file)
# RUN echo 'devasheesh:${DEVASHEESH_PASSWORD}' | chpasswd
# Optionally, grant sudo privileges to the "devasheesh" user
RUN usermod -aG sudo devasheesh

# Modify .bashrc file
RUN rm /home/devasheesh/.bashrc
COPY .bashrc /home/devasheesh/.bashrc
COPY .bashrc /root/.bashrc
RUN chown devasheesh:devasheesh /home/devasheesh/.bashrc

# Add user pip folder to PATH
# ENV PATH="/home/devasheesh/.local/bin:${PATH}"

# Install pip dependencies
USER devasheesh
# COPY requirements-pip.txt requirements-pip.txt
# RUN pip3 install --upgrade pip setuptools wheel \
#     && pip3 install -r requirements-pip.txt \
#     && pip install 'git+https://github.com/facebookresearch/detectron2.git' \
#     && pip install 'git+https://github.com/huggingface/transformers.git' \
#     && pip install 'git+https://github.com/oobabooga/torch-grammar.git' \
#     && pip3 cache purge

# Install miniconda
RUN mkdir -p ~/miniconda3 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
    && bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
    && rm -rf ~/miniconda3/miniconda.sh

USER root
# RUN rm requirements-pip.txt
