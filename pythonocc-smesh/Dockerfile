FROM continuumio/miniconda3

# install dependencies from apt-get
RUN apt-get update && apt-get install -y \
    wget bsdtar

# download code for pythonocc + smesh
RUN cd tmp \
 && wget -qO- https://github.com/tpaviot/pythonocc-generator/archive/master.zip | bsdtar -xvf- \
 && wget -qO- https://github.com/tpaviot/pythonocc-core/archive/master.zip | bsdtar -xvf- \
 && wget -qO- https://github.com/tpaviot/smesh/archive/master.zip | bsdtar -xvf-
# && wget -qO- https://github.com/tpaviot/oce/archive/master.zip | bsdtar -xvf-  


# Install dependencies for building smesh
RUN apt-get update && apt-get install -y \
    unzip cmake g++ gfortran libglu1-mesa-dev \
    man \
 && conda install -y -c dlr-sc \
    psutil oce pyqt swig    
 && conda update -y pip \
 && pip install cppheaderparser


# Install smesh
RUN cd tmp/smesh-master \
 && mkdir cmake-build \
 && cd cmake-build \
 && cmake .. \
 && make \
 && make install


# Create py2-environment
# RUN conda create -y -n py2 python=2

# conda config --add channels dlr-sc 
# OCE deps: freeimageplus freetype gl2ps tbb


CMD ["python3"]
