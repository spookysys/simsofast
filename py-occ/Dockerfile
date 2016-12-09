FROM continuumio/miniconda3

# install pythonocc
RUN conda install -c https://conda.anaconda.org/dlr-sc pythonocc-core \
        && conda clean -t

# install smesh for meshing
RUN apt-get update && apt-get install -y \
    unzip cmake g++ gfortran \
    libglu1-mesa-dev \ 
    swig3.0 \
 && wget https://github.com/tpaviot/smesh/archive/master.zip -P tmp \
 && cd tmp \
 && unzip master.zip \
 && cd smesh-master \
 && mkdir cmake-build \
 && cd cmake-build \
 && cmake .. \
 && make \
 && make install

CMD ["python3"]
