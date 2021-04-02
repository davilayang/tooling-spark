FROM tooling-spark-base:latest
# from local built image

WORKDIR /app

# install python
RUN apt-get update && apt-get install -y \
    nodejs \
    python3-pip \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && rm -rf /var/lib/apt/lists/*

# install Python dependencies
RUN pip3 install --no-cache-dir \
    "jupyterlab>=3.0.12,<4.0.0"
    # "pyspark>=3.1.1,<4.0.0"

# config jupyter lab theme
COPY ./theme-dark-extension/index.css /usr/local/share/jupyter/lab/themes/@jupyterlab/theme-dark-extension/index.css
COPY ./theme-light-extension/index.css /usr/local/share/jupyter/lab/themes/@jupyterlab/theme-light-extension/index.css

# insatll optional Python dependencies from requirements.txt
COPY requirements.txt requirements.txt 
RUN pip3 install --no-cache-dir --requirement "requirements.txt"

EXPOSE 8888

SHELL ["/bin/bassh"]
ENTRYPOINT ["jupyter", "lab"]
CMD ["--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token="]

# docker build jupyter_image/. -t spark-jupyter
# docker run -it --rm -p 8888:8888 spark-jupyter
# chrome --new-window --app=http://127.0.0.1:8888/lab

# TODO: add CSS and font to config the scene
## Fira Code Retina, Sarasa Term TC, Iosevka Term,
# TODO: another way to connect to cluster without pip install pyspark?