#!/bin/bash
# PYT3 is my chain of engineering tools running on python 3

# Install from apt-get
apt-get update -qq --fix-missing
apt-get install -qy --no-install-recommends gmsh

# Create and activate environment
conda create -qqy --name pyt3 python=3 numpy scipy mpi4py matplotlib
source activate pyt3

# Install misc
conda install -qy -c dlr-sc pythonocc-core
pip install -q --no-cache-dir meshio pygmsh pycalculix fipy

# apt-get cleanup
apt-get purge --auto-remove -qqy
rm -rf /var/lib/apt/lists/*

# conda cleanup
conda clean -t

# deactivate enviromnent
source deactivate
