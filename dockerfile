FROM ubuntu:20.04
USER root
#replace sh symbolic link of bash
#because build of dockerfile is implemented by sh, not bash
# RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh

RUN apt update && apt -y upgrade && apt install -y \
    git \
    wget \
    build-essential \
    libssl-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    zlib1g-dev
ENV HOME /root
RUN git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
ENV PYENV_ROOT $HOME/.pyenv
#Python and pip is in shims directory
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install 3.7.7
RUN pyenv local 3.7.7

#remove sh and restore sh
# RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh

WORKDIR /workspace
RUN pip install --upgrade pip && pip install \
	pipenv
RUN pipenv install --python 3.7.7