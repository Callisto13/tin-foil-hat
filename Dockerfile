FROM ubuntu:19.10

ENV TERM=xterm-256color
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y install \
    apt-utils \
    software-properties-common

RUN add-apt-repository ppa:git-core/ppa && \
    apt-get -y update && \
    apt-get -y install \
    vim \
    vim-nox \
    neovim \
    exuberant-ctags \
    fonts-inconsolata \
    pkg-config \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    shellcheck \
    silversearcher-ag \
    tree \
    direnv \
    ripgrep \
    git \
    util-linux \
    wget \
    curl \
    net-tools

RUN pip3 install neovim --user && \
    pip install neovim --user

COPY config/tmux.conf /root/.tmux.conf
COPY config/gitconfig /root/.gitconfig
COPY config/vimrc.local.plugins /root/.vimrc.local.plugins
COPY config/vimrc /root/.vimrc
COPY config/bash_aliases /root/.bash_aliases
COPY config/golang.sh /etc/profile.d/golang.sh
COPY config/vimupdate /root/.vimupdate

RUN git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm

RUN wget https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz -P /tmp && \
    tar -C /usr/local -xzf /tmp/go1.14.1.linux-amd64.tar.gz

ENV GOPATH=/root/go
ENV PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

RUN git clone https://github.com/masters-of-cats/a-new-hope /root/.config/nvim

RUN sed -i '/plugged/a silent source ~/.vimrc.local.plugins' /root/.config/nvim/init.vim && \
    echo 'silent source ~/.vimrc' >> /root/.config/nvim/init.vim

RUN curl -sSL https://get.docker.com/ | sh

RUN /usr/local/go/bin/go get sigs.k8s.io/kind && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

RUN mkdir /root/workspace

WORKDIR /root/workspace
