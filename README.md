# Tooling: Spark

## Use Case

+ Start a Docker container with Spark and Jupyter Lab installed

## Steps

```bash
# build image
docker build . -t spark-dev

# start container
docker run -it --rm -p 8888:8888 -v $(pwd):/app spark-dev /bin/bash

# start jupyter lab in container, default port 8888
jupyter lab --ip 0.0.0.0 --allow-root --no-browser

# start chrome on host without address bar
chrome --new-window --app=http://127.0.0.1:8888/lab?token=<token>
```

## References

Offcial:  

+ [Spark Overview](https://spark.apache.org/docs/latest/)

Repos:  

+ [](https://github.com/big-data-europe/docker-spark)

Articles:  

+ [DIY: Apache Spark & Docker](https://towardsdatascience.com/diy-apache-spark-docker-bb4f11c10d24)
+ [How to install PySpark and Jupyter Notebook in 3 Minutes](https://www.sicara.ai/blog/2017-05-02-get-started-pyspark-jupyter-notebook-3-minutes)

