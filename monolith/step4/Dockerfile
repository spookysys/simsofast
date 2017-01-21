FROM simsofast/monolith:step3
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
WORKDIR /tmp

# Install pyt3 toolchain
COPY install_pyt3.sh /tmp
RUN bash install_pyt3.sh \
 && rm install_pyt3.sh
 
WORKDIR /root
