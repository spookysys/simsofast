FROM simsofast/py

# Install conda and libs
RUN apt-get update -qq --fix-missing \
 && apt-get install -qy --no-install-recommends \
    gmsh \
 && pip install -q --no-cache-dir \
    pygmsh \
 && conda clean -t \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["python3"]
