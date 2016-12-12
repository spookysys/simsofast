FROM continuumio/miniconda3
# FROM buildpack-deps:jessie

# Install conda and libs
RUN apt-get update -qq --fix-missing \
 && apt-get install -qy --no-install-recommends ca-certificates \
 && apt-get install -qy --no-install-recommends gmsh \
 && conda install -qy numpy scipy \
 && conda install -qy -c dlr-sc pythonocc-core \
 && conda update -qy pip \
 && pip install -q --no-cache-dir meshio pygmsh pyfoam \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

# Install smesh
WORKDIR /tmp
RUN apt-get update -qq --fix-missing \
 && apt-get install -qy --no-install-recommends \
    wget bsdtar cmake build-essential gfortran doxygen libboost-dev \
 && wget -qO- https://github.com/tpaviot/smesh/archive/master.zip | bsdtar -xvf- && mv smesh* smesh \
 && mkdir smesh-build && cd smesh-build \
 && cmake ../smesh \
 && make -j `nprocs` \
 && make install \
 && apt-get remove -qqy \
    wget bsdtar cmake build-essential gfortran doxygen libboost-dev \
 && apt-get autoremove -qqy \
 && apt-get purge -qy \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*


WORKDIR /root
CMD ["python3"]
