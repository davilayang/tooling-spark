
from random import random

from pyspark.sql import SparkSession

N_SLICE = 10
N_THROWS = 100000 * N_SLICE

def throwDarts(_):
    x = random() * 2 - 1
    y = random() * 2 - 1

    return 1 if x ** 2 + y ** 2 <= 1 else 0


def compute_pi(spark: SparkSession): 

  num_list = list(range(N_THROWS))

  incremental_rdd = spark.sparkContext.parallelize(num_list)

  # map 
  darts_rdd = incremental_rdd.map(throwDarts)

  # reduce
  darts_in_circle = darts_rdd.reduce(lambda a,b: a+b)

  print("Pi is roughly {}".format(4.0 * darts_in_circle / N_THROWS))



if __name__ == "__main__": 

  # start a session on local cluster
  spark = SparkSession.builder\
      .appName("pyspark-compute-pi")\
      .master("spark://localhost:7077")\
      .getOrCreate()

  # run a job
  compute_pi(spark)

  # terminate the session
  spark.stop()

