FROM spookysys/py

# Install conda and libs
RUN conda install -qy -c dlr-sc \
    pythonocc-core \
 && conda clean -t

WORKDIR /root
CMD ["python3"]
