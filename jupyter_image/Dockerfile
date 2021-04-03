FROM tooling-spark-base:latest

WORKDIR /app


# installations
RUN apt-get update && apt-get install -y \
    nodejs \
    python3-pip \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && rm -rf /var/lib/apt/lists/*

# required
RUN pip3 install --no-cache-dir \
    "jupyterlab>=3.0.12,<4.0.0"

# optional
COPY requirements.txt requirements.txt 
RUN pip3 install --no-cache-dir --requirement "requirements.txt"


# configurations
COPY ./theme-dark-extension/index-dracula.css \
    /usr/local/share/jupyter/lab/themes/@jupyterlab/theme-dark-extension/index.css
COPY ./theme-light-extension/index.css \
    /usr/local/share/jupyter/lab/themes/@jupyterlab/theme-light-extension/index.css


# finalizations
EXPOSE 8888

SHELL ["/bin/bash"]
ENTRYPOINT ["jupyter", "lab"]
CMD ["--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token="]


# TODO: another way to connect to cluster without pip install pyspark?

# docker build jupyter_image/. -t local-jupyter
# docker run -it --rm -p 8888:8888 -v $(pwd)/notebooks:/app local-jupyter
# chrome --new-window --app=http://127.0.0.1:8888/lab
