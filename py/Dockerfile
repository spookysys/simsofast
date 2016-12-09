FROM continuumio/miniconda3

# Dependent dockerfiles use this a lot
RUN apt-get update -q --fix-missing \
    && apt-get install -qy --no-install-recommends wget bsdtar \
    && rm -rf /var/lib/apt/lists/*

# Install conda and libs
RUN apt-get update \
 && apt-get install -qy gmsh \
 && conda install -qy numpy scipy \
 && conda install -qy -c dlr-sc pythonocc-core \
 && conda update -qy pip \
 && pip install -q --no-cache-dir meshio pygmsh pyfoam \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["python3"]
