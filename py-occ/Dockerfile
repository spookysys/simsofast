FROM continuumio/miniconda3

RUN conda install -c https://conda.anaconda.org/dlr-sc pythonocc-core \
        && conda clean -t

CMD ["python3"]
