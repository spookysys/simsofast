FROM debian:jessie-slim
WORKDIR /tmp
SHELL ["/bin/bash", "--login", "-c"]
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Global dependencies
RUN apt-get update -qq --fix-missing \
 && apt-get install -qqy --no-install-recommends \
    ca-certificates wget bzip2 \
    python \
 && apt-get purge --auto-remove -qqy \
 && rm -rf /var/lib/apt/lists/*

# Install pip and virtualenvwrapper
RUN wget -q https://bootstrap.pypa.io/get-pip.py \
 && python get-pip.py --no-wheel \
 && rm get-pip.py \
 && pip install virtualenv virtualenvwrapper \
 && mkdir -p $HOME/.virtualenvs \
 && echo export WORKON_HOME=$HOME/.virtualenvs >> /root/.bashrc \
 && echo source /usr/local/bin/virtualenvwrapper.sh >> /root/.bashrc

# Install SU2
ARG RUN_REGRESSION
ENV SU2_RUN /usr/local/bin
ENV SU2_HOME /opt/su2
COPY install_su2.sh /tmp
RUN sh install_su2.sh
ENV PATH $SU2_RUN:$PATH
ENV PYTHONPATH $PYTHONPATH:$SU2_RUN

# Install Anaconda3
COPY install_anaconda3.sh /tmp
RUN sh install_anaconda3.sh

# Create virtualenv for SU2 python wrappers
RUN mkvirtualenv su2 \
 && workon su2 \
 && pip install -q numpy scipy mpi4py \
 && deactivate

WORKDIR /root
