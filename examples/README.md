# PySpark/Spark Examples

> examples to run with the local Spark Cluster


## PySpark 

1. Compute Pi, adapted from Chapter 4 of "Spark In Action"

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

1. 