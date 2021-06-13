FROM python:3.8.10-buster

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    openjdk-11-jdk-headless

ENV SPARK_HOME="/opt/spark"

ARG SPARK_VERSION
ARG HADOOP_VERSION

# Install Spark and Hadoop
RUN apt-get update && \
    curl -OJ https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mkdir ${SPARK_HOME}/logs \
    && rm -rf /var/lib/apt/lists/*

# Config prompt for root (escape \n with \\\n)
RUN echo "PS1='\[\e[0;37m\][\w]\\\n\[\e[0;35m\]\u\[\e[1;34m\]@🐳\[\e[1;36m\]\h\[\e[1;34m\] ❯ \[\e[0m\]'" \
    >> /etc/bash.bashrc && \
    echo "set bell-style none" >> /etc/inputrc

# Fix the value of PYTHONHASHSEED
ENV PYTHONHASHSEED 1

ENV PATH="${SPARK_HOME}/bin:${PATH}"
ENV PYSPARK_DRIVER_PYTHON=python

# Reset entrypoint and command
SHELL ["/bin/sh", "-c"]
ENTRYPOINT []
CMD ["bash"]

# docker build ./image_base -t spark_base:latest