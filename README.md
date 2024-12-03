# Tooling: Spark

Start a Spark cluster in Standalone mode with Jupyter server

## Usage

> start a Spark cluster using Standalone cluster manager

1. Build the containers and create virtual environment from `requirements.txt`
    + `make build`
2. Start the Spark cluster and Jupyter server
    + `make start`
3. Access the Jupyter server with Google Chrome
    + `google-chrome --incognito --app=http://localhost:8888/lab`
    + `google-chrome --new-window --app=http://localhost:8888/lab`
4. Stop the cluster and remove all created volumes
    + `make down`

### Submit a PySpark job

> submit from host machine, published master port at 7077

+ For Python job dependencies, add to `requirements.txt`, then `make build` and `make start`
+ For JAVA dependencies, add to `--packages` flag using Apache Maven coordinates, separated by comma
+ Using `spark-submit` of PySpark environment is sufficient (e.g. `conda`), but note that Python and PySpark version should match 

```bash
export PYSPARK_DRIVER_PYTHON=python
export PYSPARK_PYTHON=./environment/bin/python

spark-submit \
    --master spark://localhost:7077 \
    --archives mounted_dirs/jobs/pyspark_vevn.tar.gz \
    --packages <maven-package-coordinates> \
    <pyspark-job-file>.py
```

### Submit a Spark job 

> submit from host machine, published master post at 7077

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

TODO: can --files work with adding a csv file and then reading into DataFrame?

Note that the absolute path should be the same as the path to load uploaded files in applications

## Service ports 

+ Jupyter Lab server at http://localhost:8888/lab
+ Spark master Web UI at http://localhost:4040 (started by a SparkSession)
+ Spark master UI at http://localhost:8080
+ Spark worker 1 UI at http://localhost:8081
+ Spark worker 2 UI at http://localhost:8082

## References

+ [Spark Overview](https://spark.apache.org/docs/latest/)
