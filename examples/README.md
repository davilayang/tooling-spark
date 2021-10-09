# PySpark/Spark Examples

> examples to run with the local Spark Cluster


## PySpark 

1. Compute Pi, adapted from Chapter 5 of "Spark In Action"

```bash
spark-submit --deploy-mode client --master spark://localhost:7077 \
  examples/pyspark-compute-pi/compute_pi.py

# Or, since the application already specifies master and default mode is "client"
spark-submit examples/pyspark-compute-pi/compute_pi.py
```

2.  ...

Submit with JAVA dependencies

```bash
spark-submit --deploy-mode client --master spark://localhost:7077 \
  --packages org.postgresql:postgresql:42.2.24 \
  examples/pyspark-compute-pi/compute_pi.py 
```

spark.jars.packages?

## Spark

1. Compute Pi, adapted from Chapter 5 of "Spark In Action"

Initializing and packaging the Scala project

```bash
cd examples/spark-compute-pi
touch build.sbt
sbt # sbt shell
```

```bash
set scalaVersion := "2.12.10"
session save
# saved to build.sbt
```

```bash
sbt package
conda activate pyspark
spark-submit --deploy-mode client --master spark://localhost:7077 \
  --class my.example.pi_compute.PiComputeScalaExample \
  target/scala-2.12/spark-compute-pi_2.12-0.1.0-SNAPSHOT.jar
```


## Reference

+ [Scala 2, Getting Started](https://docs.scala-lang.org/getting-started/index.html)
+ [sbt by example](https://www.scala-sbt.org/1.x/docs/sbt-by-example.html)
+ [Apache Spark Examples](https://spark.apache.org/examples.html)