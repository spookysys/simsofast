FROM continuumio/miniconda3

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
