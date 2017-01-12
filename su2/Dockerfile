FROM buildpack-deps:jessie-curl
WORKDIR /tmp

ARG RUN_REGRESSION
ENV SU2_RUN /usr/local/bin
ENV SU2_HOME /opt/su2

COPY install_su2.sh /tmp
RUN sh /tmp/install_su2.sh

ENV PATH $SU2_RUN:$PATH
ENV PYTHONPATH $PYTHONPATH:$SU2_RUN

WORKDIR /root
