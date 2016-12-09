FROM continuumio/miniconda3

RUN apt-get update \
 && apt-get install -y gmsh \
 && conda install -y numpy \
 && conda install -y -c dlr-sc pythonocc-core \
 && conda update -y pip \
 && pip install --no-cache-dir meshio pygmsh \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["python3"]
