FROM ubuntu:14.04
# FROM buildpack-deps:jessie
# FROM spookysys/simsofast-py
# FROM continuumio/miniconda3

RUN apt-get update -qq --fix-missing \
    && apt-get install -qqy --no-install-recommends ca-certificates wget bsdtar \
    && rm -rf /var/lib/apt/lists/*

# Install Python
WORKDIR /tmp
RUN wget -qO tmp.sh https://repo.continuum.io/miniconda/Miniconda2-4.2.12-Linux-x86_64.sh \
 && bash tmp.sh -b -p /opt/conda \
 && rm tmp.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install -qy numpy scipy \
 && conda clean -t

# Install SU2 binary version (Note: no libs)
# WORKDIR /tmp
# COPY su2-4.3.0-ubuntu14.04-gcc.tgz ./tmp.tgz
# RUN tar xvfz tmp.tgz \
#  && rm tmp.tgz \
#  && mv su2* su2 \
#  && mv su2 /opt
# ENV PATH /opt/su2/bin:$PATH

# Install SU2 from source
WORKDIR /tmp
RUN apt-get update -qq --fix-missing \
 && apt-get install -qy \
    automake build-essential \
    libopenmpi-dev openmpi-bin \
    libopenblas-base liblapack3gf libopenblas-dev liblapack-dev liblapacke-dev \
 && conda install -qy swig

RUN wget -qO- https://github.com/su2code/SU2/archive/v4.3.0.zip | bsdtar -xvf- \
 && mv SU* su2 && mv su2 /opt && cd /opt/su2 && chmod a+x configure preconfigure.py
 && sed -ri -e 's|(PYTHON_INCLUDE\s=\s).*|\1-I/opt/conda/include/python2.7|g' SU2_PY/pySU2/Makefile.* \
 && sed -ri -e 's|(NUMPY_INCLUDE\s=\s).*|\1-I/opt/conda/lib/python2.7/site-packages/numpy/core/include|g' SU2_PY/pySU2/Makefile.* \
 && ./configure \
    CXXFLAGS="-O2 -g" \
    --enable-mpi --with-cc=/usr/bin/mpicc --with-cxx=/usr/bin/mpicxx \
    --with-LAPACK-lib=/usr/lib --with-LAPACK-include=/usr/include \
    --enable-PY_WRAPPER \
&& make -j `nproc` \
&& make check \
&& make install

# RUN wget -qO- https://github.com/su2code/SU2/archive/v4.3.0.zip | bsdtar -xvf- \
#  && apt-get update -qq --fix-missing \
#  && apt-get install -qy automake build-essential

# superfast 
# CXXFLAGS="-O0" --enable-CFD --disable-DOT --disable-MSH --disable-DEF --disable-SOL --disable-GEO

# --enable-mpi --with-cc=/usr/bin/mpicc --with-cxx=/usr/bin/mpicxx
# RUN apt-get install -qy libopenmpi-dev openmpi-bin

# --with-LAPACK-lib=/usr/lib --with-LAPACK-include=/usr/include
# RUN apt-get install -qy libopenblas-base liblapack3gf libopenblas-dev liblapack-dev liblapacke-dev

# --with-Jsoncpp-include=/usr/include/jsoncpp --with-Jsoncpp-lib=/usr/lib/x86_64-linux-gnu
# RUN apt-get install -qy libjsoncpp-dev \
#  && ln -s /usr/lib/x86_64-linux-gnu/libjsoncpp.a /usr/lib/x86_64-linux-gnu/libjson.a

# --enable-PY_WRAPPER
# RUN conda install -qy swig

WORKDIR /root
