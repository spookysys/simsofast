FROM ubuntu:14.04
# FROM buildpack-deps:jessie
# FROM spookysys/simsofast-py

ENV SU2_RUN /usr/local/bin
ENV SU2_HOME /opt/su2

WORKDIR /tmp
RUN apt-get update -qq --fix-missing \
 && apt-get install -qqy --no-install-recommends \
    ca-certificates wget bsdtar \
    automake build-essential \
    python python-pip \
    libopenmpi-dev openmpi-bin libopenmpi1.6 ssh \
    libopenblas-base liblapack3gf libopenblas-dev liblapack-dev liblapacke liblapacke-dev \
 && pip install -q --upgrade pip \
 && pip install -q --no-cache-dir numpy scipy swig mpi4py \
 && wget -qO- https://github.com/su2code/SU2/archive/v4.3.0.zip | bsdtar -xvf- && mv SU2* SU2 \
 && wget -qO- https://github.com/su2code/TestCases/archive/v4.3.0.zip | bsdtar -xvf- && mv TestCases* TestCases \
 && mkdir -p $SU2_HOME \
 && cp -R SU2/* $SU2_HOME \
 && cd /tmp/SU2 \
 && sed -ri -e 's|(TECIO_LIB\s=).*|\1|g' SU2_PY/pySU2/Makefile.* \
 && cp -R ../TestCases/* TestCases \
 && chmod ug+x configure preconfigure.py \
 && ./configure \
    CXXFLAGS="-O2 -g" \
    --enable-mpi --with-cc=/usr/bin/mpicc --with-cxx=/usr/bin/mpicxx \
    --with-LAPACK-lib=/usr/lib --with-LAPACK-include=/usr/include \
    --enable-PY_WRAPPER \
 && make -j `nproc` \
 && make check \
 && make install \
 && apt-get remove -qqy \
    bsdtar liblapack-dev liblapacke-dev \
    automake build-essential \
 && apt-get autoremove -qqy \
 && cd /tmp/SU2/TestCases \
 && python parallel_regression.py \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*

# && sed -ri -e 's|(PYTHON_INCLUDE\s=\s).*|\1-I/opt/conda/include/python2.7|g' SU2_PY/pySU2/Makefile.* \
# && sed -ri -e 's|(NUMPY_INCLUDE\s=\s).*|\1/opt/conda/lib/python2.7/site-packages/numpy/core/include|g' SU2_PY/pySU2/Makefile.* \

ENV PATH $SU2_RUN:$PATH
ENV PYTHONPATH $PYTHONPATH:$SU2_RUN

WORKDIR /root
