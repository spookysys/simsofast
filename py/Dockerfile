FROM continuumio/miniconda3
# FROM buildpack-deps:jessie

# Install conda and libs
RUN apt-get update -qq --fix-missing \
 && apt-get install -qy --no-install-recommends ca-certificates \
 && apt-get install -qy --no-install-recommends gmsh \
 && conda install -qy numpy scipy \
 && conda install -qy -c dlr-sc pythonocc-core \
 && conda update -qy pip \
 && pip install -q --no-cache-dir meshio pygmsh pyfoam \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["python3"]
