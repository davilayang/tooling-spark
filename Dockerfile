FROM openjdk:11-slim-buster

ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=3.2

# Fix the value of PYTHONHASHSEED
ENV PYTHONHASHSEED 1

WORKDIR /app

# install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    python3.7 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# install SPARK
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# install Python dependencies
COPY start-cluster.sh start-cluster.sh
COPY requirements.txt requirements.txt 
RUN pip3 install --no-cache-dir --requirement "requirements.txt"

ENV SPARK_HOME="/opt/spark"
ENV PATH="/opt/spark/bin:${PATH}"
ENV PYSPARK_DRIVER_PYTHON=ipython

# config the terminal
RUN echo "PS1='\[\033[0;37m\][\w]\n\[\e[1;35m\]\u\[\033[1;34m\]@🐳\[\033[1;36m\]\h\[\033[1;34m\] ❯ \[\033[0m\]'" >> ~/.bashrc &&\
    echo "set bell-style none" >> /etc/inputrc

# reset entrypoint 
SHELL ["/bin/sh", "-c"]
ENTRYPOINT []
CMD ["bash"]

# usage:
# docker build . -t spark-dev
# docker run -it --rm spark-dev /bin/bash

# TODO: use image "alpine:latest"
# TODO: separate required pypi pacakges with optional?
# TOOD: use multi-stage build to reduce the layers created (docker best practices)