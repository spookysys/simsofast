FROM continuumio/miniconda3

RUN apt-get update -qq --fix-missing \
 && conda update -qy pip \
 && apt-get install -qy --no-install-recommends \
    ca-certificates \
 && conda install -qy \
    numpy scipy \
 && pip install -q --no-cache-dir \
    meshio \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["python3"]
