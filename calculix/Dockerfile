FROM spookysys/simsofast-py

# Install conda and libs
RUN apt-get update -qq --fix-missing \
 && apt-get install -qy --no-install-recommends \
    ca-certificates \
    gmsh \
 && conda update -qy pip \
 && conda install -qy \
    matplotlib \
 && pip install -q --no-cache-dir \
    pycalculix \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

# TODO: Calculix

WORKDIR /root
CMD ["python3"]
