# Tooling: Spark

## Use Case

+ Start a Docker container with Spark and Jupyter Lab installed

## Steps

```bash
# build image
docker build . -t spark-dev

# start container
docker run -it --rm -p 8888:8888 -p 4040:4040 -v $(pwd):/app spark-dev /bin/bash
```

Spark UI is at http://localhost:4040

### Start with Juppyter Lab

(Approach 1, with `pyspark` using Jupyter as Driver)

```bash
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='lab --ip 0.0.0.0 --allow-root --no-browser'

# jupyter lab in container, default port 8888
pyspark 
# start chrome on host without address bar
chrome --new-window --app=http://127.0.0.1:8888/lab?token=<token>
```

```python
sc # for SparkContext
spark # for SparkSession
```

(Approach 2, with package `findspark`)

```bash
conda install -c conda-forge findspark

# start jupyter lab in container, default port 8888
jupyter lab --ip 0.0.0.0 --allow-root --no-browser
# start chrome on host without address bar
chrome --new-window --app=http://127.0.0.1:8888/lab?token=<token>
```

```python
import findspark
import pyspark

findspark.init()
findspark.find()

from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession
conf = pyspark.SparkConf().setAppName('appName').setMaster('local')
sc = pyspark.SparkContext(conf=conf)
spark = SparkSession(sc)
```

## References

Official:  

+ [Spark Overview](https://spark.apache.org/docs/latest/)
+ [Spark Standalone Mode](http://spark.apache.org/docs/latest/spark-standalone.html)

Repos:  

+ [docker-spark](https://github.com/big-data-europe/docker-spark)
+ [docker-spark-cluster](https://github.com/mvillarrealb/docker-spark-cluster)
+ [docker-sbt](https://github.com/mozilla/docker-sbt/blob/main/Dockerfile)

Articles:  

+ [DIY: Apache Spark & Docker](https://towardsdatascience.com/diy-apache-spark-docker-bb4f11c10d24)
+ [How to install PySpark and Jupyter Notebook in 3 Minutes](https://www.sicara.ai/blog/2017-05-02-get-started-pyspark-jupyter-notebook-3-minutes)
+ [Creating a Spark Standalone Cluster with Docker and docker-compose](https://medium.com/@marcovillarreal_40011/creating-a-spark-standalone-cluster-with-docker-and-docker-compose-ba9d743a157f)
+ [透過 Multiple Stage Builds 編譯出最小的 Docker Image](https://jiepeng.me/2018/06/09/use-docker-multiple-stage-builds)