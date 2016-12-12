FROM simsofast/py

RUN apt-get update -qq --fix-missing \
 && apt-get install -qy --no-install-recommends \
    gmsh \
 && pip install -q --no-cache-dir \
    pygmsh \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root
ENTRYPOINT "python3"