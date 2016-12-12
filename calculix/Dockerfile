FROM simsofast/gmsh

# TODO: Calculix

RUN conda install -qy \
    matplotlib \
 && pip install -q --no-cache-dir \
    pycalculix \
 && conda clean -t
 
WORKDIR /root
CMD ["python3"]
