FROM ubuntu:14.04
# FROM buildpack-deps:jessie
# FROM spookysys/simsofast-py


# Install SU2 binary version (Note: no libs)
# WORKDIR /tmp
# COPY su2-4.3.0-ubuntu14.04-gcc.tgz ./tmp.tgz
# RUN tar xvfz tmp.tgz \
#  && rm tmp.tgz \
#  && mv su2* su2 \
#  && mv su2 /opt
# ENV PATH /opt/su2/bin:$PATH

ENV SU2_RUN /usr/local/bin
ENV SU2_HOME /opt/su2
ENV CONDA_BIN /opt/conda/bin

WORKDIR /tmp
RUN apt-get update -qq --fix-missing \
 && apt-get install -qqy --no-install-recommends \
    ca-certificates wget bsdtar \
    automake build-essential \
    libopenmpi-dev openmpi-bin \
    libopenblas-base liblapack3gf libopenblas-dev liblapack-dev liblapacke liblapacke-dev \
 && wget -qO tmp.sh https://repo.continuum.io/miniconda/Miniconda2-4.2.12-Linux-x86_64.sh && bash tmp.sh -b -p /opt/conda && rm tmp.sh \
 && export PATH=$CONDA_BIN:$PATH \
 && conda install -qy \
    numpy scipy \
    swig
RUN wget -qO- https://github.com/su2code/SU2/archive/v4.3.0.zip | bsdtar -xvf- \
 && mv SU* su2 && mv su2 /opt \
 && cd $SU2_HOME && chmod a+x configure preconfigure.py

ENV PATH $CONDA_BIN:$PATH

WORKDIR $SU2_HOME
RUN sed -ri -e 's|(TECIO_LIB\s=).*|\1|g' SU2_PY/pySU2/Makefile.* \
 && sed -ri -e 's|(PYTHON_INCLUDE\s=\s).*|\1-I/opt/conda/include/python2.7|g' SU2_PY/pySU2/Makefile.* \
 && sed -ri -e 's|(NUMPY_INCLUDE\s=\s).*|\1/opt/conda/lib/python2.7/site-packages/numpy/core/include|g' SU2_PY/pySU2/Makefile.*
RUN ./configure \
    CXXFLAGS="-O2 -g" \
    --enable-mpi --with-cc=/usr/bin/mpicc --with-cxx=/usr/bin/mpicxx \
    --with-LAPACK-lib=/usr/lib --with-LAPACK-include=/usr/include \
    --enable-PY_WRAPPER
RUN make -j `nproc`
RUN make check
RUN apt-get remove -qqy \
    bsdtar libopenblas-dev liblapack-dev liblapacke-dev \
 && apt-get autoremove -qqy
RUN conda uninstall swig
RUN make check
RUN make install
RUN apt-get remove -qqy \
    automake build-essential libopenmpi-dev \
 && apt-get autoremove -qqy \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

ENV PATH $SU2_RUN:$PATH
ENV PYTHONPATH $PYTHONPATH:$SU2_RUN
 
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

# ./configure --prefix=/opt/su2 --enable-tecio CXXFLAGS="-I/usr/include/X11 -O0" --enable-CFD --disable-DOT --disable-MSH --disable-DEF --disable-SOL --disable-GEO

WORKDIR /root
