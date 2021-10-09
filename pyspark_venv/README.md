# pyspark_venv

Builds Python dependencies as archvies and then submit PySpark job with it

## Instructions

This differs by the deploy mode of a job. Remember that client mode is the default and only option for interactive session, and it's when the executing machine is the "Driver" for the submitted PySpark job. 
For "Cluster" mode, the job is submitted to the cluster and "Driver" is in the cluster.  

### In Client deploy mode

Always make sure the dependencies are already installed in Python of the executing machine. Since itself is the driver program, it must have all the dependencies. 

From host machine: 

```bash
export PYSPARK_DRIVER_PYTHON=python
export PYSPARK_PYTHON=./environment/bin/python
spark-submit --master spark://localhost:7077 \
  --archives mounted_dirs/jobs/pyspark_venv.tar.gz#environment \
  mounted_dirs/jobs/sample.py

unset PYSPARK_DRIVER_PYTHON
unset PYSPARK_PYTHON
```

From a service container, e.g. `jupyter-server`: 

```bash
# from shell
export PYSPARK_DRIVER_PYTHON=python
export PYSPARK_PYTHON=./environment/bin/python
spark-submit --master spark://spark-master:7077 \
  --archives /app/jobs/pyspark_venv.tar.gz#environment \
  /app/jobs/sample.py

unset PYSPARK_DRIVER_PYTHON
unset PYSPARK_PYTHON
```

```python
# from python
import os
from pyspark.sql import SparkSession 
os.environ['PYSPARK_PYTHON'] = "./environment/bin/python"

spark = SparkSession.builder\
    .appName("pyspark-notebook-dep")\
    .master("spark://spark-master:7077")\
    .config("spark.archives", "/app/jobs/pyspark_venv.tar.gz#environment")\
    .getOrCreate()
```

### In Cluster deploy mode

The executing machine won't be requires to have the dependencies, but PySpark with Standalone cluster manager doesn't support Cluster deploy mode yet. 

TODO: try with other cluster managers, e.g. Kubernetes

## Notes

When using `venv` from Python, the created virutal environment is using symbolic link to point to Python interpreter of local system by default. However, the path to Python on host machine (i.e. local system) is different than that of Spark nodes. On the Spark nodes of this repository, Python is at `/usr/local/bin/Python`. 

So simply building the archived dependencies from host machine dose not work. Because when Spark extracts the archvie and tries to run its Python, it cannot find the correct Python on the workers.  

For Python archived dependencies to work with this multi-node cluster (including Spark and Jupyter Server): 

1. Define once for the Python job requirements
2. Install the dependencies on Jupyter Server
3. Package the dependencies from spark-like container
4. Use the dependencies by 
    - specifying environment variable `PYSPARK_PYTHON` (for workers to use extracted Python)
    - with `--archives` flag or `spark.archives` in config (for adding archvie to workers)   

## References

+ [Python Package Management](https://spark.apache.org/docs/latest/api/python/user_guide/python_packaging.html)
+ [How to Manage Python Dependencies in PySpark](https://databricks.com/blog/2020/12/22/how-to-manage-python-dependencies-in-pyspark.html)