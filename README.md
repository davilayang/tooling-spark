# Tooling: Spark

## Use Case

+ Start a Docker container with Spark
+ Start a SPARK cluster with single worker

## Start a Docker container with Spark

```bash
# build the image
docker build . -t spark-dev
```

### Jupyter Lab in Local mode

```bash
# start container
docker run -it --rm -p 8888:8888 -p 4040:4040 -v $(pwd):/app spark-dev /bin/bash
```

+ Spark UI at http://localhost:4040
+ Jupyter Lab at http://localhost:8888

### Approach 1, `PYSPARK_DRIVER`

(in SPARK container)

```bash
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='lab --ip 0.0.0.0 --allow-root --no-browser'

# start jupyter lab, default port 8888; copy the token as <token>
pyspark
```

(in host machine)

```bash
# start chrome on host without address bar
chrome --new-window --app=http://127.0.0.1:8888/lab?token=<token>
```

(in jupyter notebook cell)

```python
sc #for SparkContext
spark #for SparkSession
```

### Approach 2, `findspark`

(in SPARK container)

```bash
# install package
pip3 install findspark

# start jupyter lab in container, default port 8888; copy the token as <token>
jupyter lab --ip 0.0.0.0 --allow-root --no-browser
```

(in host machine)

```bash
# start chrome on host without address bar
chrome --new-window --app=http://127.0.0.1:8888/lab?token=<token>
```

(in jupyter notebook cell)

```python
# find the spark installation on system
import findspark
findspark.init()
findspark.find()

# start spark, also logged to jupyter
import pyspark
from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession
conf = pyspark.SparkConf().setAppName('appName').setMaster('local')
sc = pyspark.SparkContext(conf=conf) #for SparkContext
spark = SparkSession(sc) #for SparkSession
```

## Start a SPARK cluster with single worker

```bash
# build and start the cluster
docker-compose up --build 
# build and start the cluster in detached mode
docker-compose up --build --detach

# stop the cluster
docker-compose down
```

+ Spark Master UI at: http://localhost:8088/
+ Spark Worker UI at: http://localhost:8081/

(interactive shell within the cluster)

```bash
# exec into master or worker
docker exec -it tooling-spark_spark-master_1 /bin/bash
# start pyspark
pyspark --master spark://spark-master:7077
```

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