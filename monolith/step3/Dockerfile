FROM simsofast/monolith:step2
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
WORKDIR /tmp

# Install calculix
COPY ../install_calculix.sh /tmp
RUN bash install_calculix.sh \
 && rm install_calculix.sh
 
WORKDIR /root
