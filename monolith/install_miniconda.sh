#!/bin/bash

# apt-get dependencies
apt-get update -qq --fix-missing
apt-get install -qqy --no-install-recommends \
    libglib2.0-0 libxext6 libsm6 libxrender1
apt-get purge --auto-remove -qqy
rm -rf /var/lib/apt/lists/*

# Install conda
echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh
wget -q https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p /opt/conda
rm miniconda.sh
