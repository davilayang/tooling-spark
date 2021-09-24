FROM spark_base:latest

WORKDIR /app

# installations
RUN apt-get update && curl -fsSL https://deb.nodesource.com/setup_15.x | bash - \
    && apt-get install -y \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

ARG USER_UID
ARG USER_NAME
ARG SPARK_VERSION

RUN useradd --create-home --shell /bin/bash --uid ${USER_UID} ${USER_NAME}

USER ${USER_NAME}

ENV PATH="/home/${USER_NAME}/.local/bin:${PATH}"

# required Python packages 
RUN pip install --user --no-cache-dir --upgrade \
    "jupyterlab>=3.0.12,<4.0.0" \
    "jupyterlab-vim>=0.14.2,<1.0.0" \
    "pyspark==${SPARK_VERSION}"

# additional Python packages
COPY requirements.txt requirements.txt
RUN pip install --user --no-cache-dir -r requirements.txt

# using scala in jupyter notebook
RUN pip install --user spylon-kernel
RUN python -m spylon_kernel install --user

# config jupyter theme, theme: dracula or monokai
COPY ./theme-dark-extension/index-dracula.css \
    /home/${USER_NAME}/.local/share/jupyter/lab/themes/@jupyterlab/theme-dark-extension/index.css
COPY ./theme-light-extension/index.css \
    /home/${USER_NAME}/.local/share/jupyter/lab/themes/@jupyterlab/theme-light-extension/index.css
# config prompt for user
RUN echo "PS1='\[\e[0;37m\][\w]\\\n\[\e[1;35m\]\u\[\e[1;34m\]@🐳\[\e[1;36m\]\h\[\e[1;34m\] ❯ \[\e[0m\]'" \
    >> /home/${USER_NAME}/.bashrc

# finalizations
EXPOSE 8888

ENTRYPOINT ["jupyter", "lab"]
CMD ["--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token="]

# docker build image_jupyter/. -t spark-jupyter
# docker run -it --rm -p 8888:8888 -v $(pwd)/notebooks:/app spark-jupyter
# google-chrome --new-window --app=http://127.0.0.1:8888/lab
