FROM tooling-spark-base:latest
# from local built image

# install SPARK at /opt/spark
ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=3.2

RUN apt-get update && \
    wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz


ENV SPARK_HOME="/opt/spark"
ENV PATH="/opt/spark/bin:${PATH}"
ENV PYSPARK_DRIVER_PYTHON=python3

