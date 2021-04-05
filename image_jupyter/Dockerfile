FROM tooling-spark_base:latest

WORKDIR /app

# installations
RUN apt-get update && curl -fsSL https://deb.nodesource.com/setup_15.x | bash - \
    && apt-get install -y \
    nodejs \
    python3-pip \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && rm -rf /var/lib/apt/lists/*

ARG USER_UID
ARG USER_NAME
ARG SPARK_VERSION

RUN useradd --create-home --shell /bin/bash --uid 1000 ${USER_NAME}

USER ${USER_NAME}

ENV PATH="/home/${USER_NAME}/.local/bin:${PATH}"

# required
RUN pip3 install --user --no-cache-dir \
    "jupyterlab>=3.0.12,<4.0.0" \
    "pyspark==${SPARK_VERSION}"

# optional
COPY requirements.txt requirements.txt 
RUN pip3 install --user --no-cache-dir --requirement "requirements.txt"

# configurations, theme: dracula or monokai
COPY ./theme-dark-extension/index-dracula.css \
    /home/${USER_NAME}/.local/share/jupyter/lab/themes/@jupyterlab/theme-dark-extension/index.css
COPY ./theme-light-extension/index.css \
    /home/${USER_NAME}/.local/share/jupyter/lab/themes/@jupyterlab/theme-light-extension/index.css

# finalizations
EXPOSE 8888

ENTRYPOINT ["jupyter", "lab"]
CMD ["--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token="]

# TODO: another way to connect to cluster without pip install pyspark?

# docker build image_jupyter/. -t local-spark-jupyter
# docker run -it --rm -p 8888:8888 -v $(pwd)/notebooks:/app local-spark-jupyter
# chrome --new-window --app=http://127.0.0.1:8888/lab
