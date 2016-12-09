FROM ubuntu:14.04
# FROM debian:jessie

RUN apt-get update && apt-get install -y \
    wget bsdtar \
    && rm -rf /var/lib/apt/lists/*

# Install Python
WORKDIR /tmp
RUN wget -qO tmp.sh https://repo.continuum.io/miniconda/Miniconda2-4.2.12-Linux-x86_64.sh \
 && bash tmp.sh -b -p /opt/conda \
 && rm tmp.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install -y numpy scipy \
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
RUN wget -qO- https://github.com/su2code/SU2/archive/v4.3.0.zip | bsdtar -xvf-
RUN apt-get update && apt-get install -y \
    automake build-essential libopenmpi-dev openmpi-bin
RUN cd SU2* \
 && ./configure; make; make install
 
