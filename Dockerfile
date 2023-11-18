FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y sudo

COPY requirements-apt.txt requirements-apt.txt
RUN xargs apt-get install -y < requirements-apt.txt
RUN rm requirements-apt.txt

RUN pip3 install --upgrade pip setuptools wheel

COPY requirements-pip.txt requirements-pip.txt
RUN pip3 install -r requirements-pip.txt
RUN rm requirements-pip.txt

RUN pip install 'git+https://github.com/facebookresearch/detectron2.git'

RUN wget https://az764295.vo.msecnd.net/stable/f1b07bd25dfad64b0167beb15359ae573aecd2cc/vscode_cli_alpine_x64_cli.tar.gz && tar -xvf vscode_cli_alpine_x64_cli.tar.gz && mv code /usr/local/bin/code && rm vscode_cli_alpine_x64_cli.tar.gz

RUN pip3 cache purge && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*