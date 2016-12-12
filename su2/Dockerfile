FROM buildpack-deps:jessie-curl

ARG RUN_REGRESSION
ENV SU2_RUN /usr/local/bin
ENV SU2_HOME /opt/su2

WORKDIR /tmp
COPY kjel.sh /tmp
RUN sh /tmp/kjel.sh

ENV PATH $SU2_RUN:$PATH
ENV PYTHONPATH $PYTHONPATH:$SU2_RUN



WORKDIR /root
ENTRYPOINT "python"
