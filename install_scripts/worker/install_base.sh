#!/bin/bash

# apt-get dependencies
sudo apt-get update -qq --fix-missing
sudo apt-get install -qqy \
	nano htop less locate xauth \
    ca-certificates curl wget bzip2 \
    automake build-essential ssh \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    mpich2 libopenblas-base liblapack3gf liblapacke

# Install conda
sudo echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh
wget -q https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
sudo bash miniconda.sh -b -p /opt/conda
rm miniconda.sh

conda config --add channels conda-forge dlr-sc bryanwweber