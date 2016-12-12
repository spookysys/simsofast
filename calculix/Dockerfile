FROM simsofast/gmsh

# Install conda and libs
RUN conda install -qy \
    matplotlib \
 && pip install -q --no-cache-dir \
    pycalculix \
 && conda clean -t
 
# TODO: Calculix

WORKDIR /root
CMD ["python3"]
