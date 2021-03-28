FROM openjdk:11-slim-buster

ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=3.2

WORKDIR /app

RUN apt-get update && apt-get install -y \
    wget \
    python3.7 \
    python3-pip

RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN pip3 install ipython

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

ENV SPARK_HOME="/opt/spark"
ENV PATH="${SPARK_HOME}/bin:${PATH}"
ENV PYSPARK_DRIVER_PYTHON=ipython
# RUN export PYSPARK_DRIVER_PYTHON=ipython


# final image based on alpine
# FROM alpine:latest

