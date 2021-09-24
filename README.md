# Tooling: Spark

Start a Spark cluster in Standalone mode with Jupyter server

## Basic Usage (Spark cluster in Standalone mode)

1. Build the containers and create virtual environment from `requirements.txt`
    + `make build`
2. Start the Spark cluster and Jupyter server
    + `make start`
3. Access the Jupyter server with Google Chrome
    + `google-chrome --incognito --app=http://localhost:8888/lab`
    + `google-chrome --new-window --app=http://localhost:8888/lab`
4. Stop the cluster and remove all created volumes
    + `make down`

### Submit a PySpark job from host machine

> submit from host machine, master port is 7077

```bash
spark-submit --master spark://localhost:7077 <pyspark-job-file>
```

### Submit a Spark job from host machine

```bash
# build the JAR file
sbt package
# using PySpark spark-submit command
conda activate pyspark
# submit with additional files
spark-submit --master spark://localhost:7077 \
    --deploy-mode client \
    --class <class> \
    --files <absolute-path-to-some-file> \
    <path-to-JAR>
```

Note that the absolute path should be the same as the path to load uploaded files in applications

## Start a Spark cluster in Local mode 

Build the image

```bash
# build the image with Pyspark==3.1.1
docker build -t spark_jupyter-server \
    --build-arg USER_UID=$(id --user $USER) \
    --build-arg USER_NAME=$USER \
    --build-arg SPARK_VERSION=3.1.1 \
    ./image_jupyter
```

Start the Jupyter container with Pyspark

```bash
# start the jupyter container
docker run -it --rm -p 8888:8888 \
    -v $(pwd)/mounted_dirs/notebooks:/app/notebooks \
    -v $(pwd)/mounted_dirs/data:/app/data \
    -v $(pwd)/mounted_dirs/jobs:/app/jobs \
    spark_jupyter-server
```

## Service ports 

+ Jupyter Lab server at http://localhost:8888/lab
+ Spark master Web UI at http://localhost:4040 (started by a SparkSession)
+ Spark master UI at http://localhost:8080
+ Spark worker 1 UI at http://localhost:8081
+ Spark worker 2 UI at http://localhost:8082

## References

Official:  

+ [Spark Overview](https://spark.apache.org/docs/latest/)
+ [Spark Standalone Mode](http://spark.apache.org/docs/latest/spark-standalone.html)

Repos:  

+ [docker-spark](https://github.com/big-data-europe/docker-spark)
+ [docker-spark-cluster](https://github.com/mvillarrealb/docker-spark-cluster)
+ [docker-sbt](https://github.com/mozilla/docker-sbt/blob/main/Dockerfile)
+ [apache/spark, Dockerfile](https://github.com/apache/spark/blob/master/resource-managers/kubernetes/docker/src/main/dockerfiles/spark/Dockerfile)

Articles:  

+ [DIY: Apache Spark & Docker](https://towardsdatascience.com/diy-apache-spark-docker-bb4f11c10d24)
+ [How to install PySpark and Jupyter Notebook in 3 Minutes](https://www.sicara.ai/blog/2017-05-02-get-started-pyspark-jupyter-notebook-3-minutes)
+ [Creating a Spark Standalone Cluster with Docker and docker-compose](https://medium.com/@marcovillarreal_40011/creating-a-spark-standalone-cluster-with-docker-and-docker-compose-ba9d743a157f)
+ [透過 Multiple Stage Builds 編譯出最小的 Docker Image](https://jiepeng.me/2018/06/09/use-docker-multiple-stage-builds)
+ [Apache Spark Cluster on Docker](https://www.kdnuggets.com/2020/07/apache-spark-cluster-docker.html)
+ [Apache Spark on Dataproc vs. Google BigQuery](https://www.kdnuggets.com/2020/07/apache-spark-dataproc-vs-google-bigquery.html)
