FROM debian:jessie-slim
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
WORKDIR /tmp

# Global dependencies
RUN apt-get update -qq --fix-missing \
 && apt-get install -qqy --no-install-recommends \
    ca-certificates wget bzip2 \
 && apt-get purge --auto-remove -qqy \
 && rm -rf /var/lib/apt/lists/*

# Install miniconda
COPY install_miniconda.sh /tmp
RUN bash install_miniconda.sh \
 && rm install_miniconda.sh
ENV PATH /opt/conda/bin:$PATH

# Install SU2 (with its own py2 enviroment)
ARG RUN_REGRESSION
ENV SU2_RUN /usr/local/bin
ENV SU2_HOME /opt/su2
ENV PATH $PATH:$SU2_RUN
ENV PYTHONPATH $PYTHONPATH:$SU2_RUN
COPY install_su2.sh /tmp
RUN bash install_su2.sh \
 && rm install_su2.sh

# Install calculix
COPY install_calculix.sh /tmp
RUN bash install_calculix.sh \
 && rm install_calculix.sh
 
# Install pyt3 toolchain
COPY install_pyt3.sh /tmp
RUN bash install_pyt3.sh \
 && rm install_pyt3.sh

WORKDIR /root
