from pyspark.sql import SparkSession
from pyspark.mllib.random import RandomRDDs

def main(spark):

    x = RandomRDDs.normalVectorRDD(
        spark.sparkContext, 
        numRows=10000, 
        numCols=5, 
        numPartitions=20, 
        seed=42
    )
    print(x.collect()[:3])


if __name__ == "__main__":
    main(SparkSession.builder.getOrCreate())

# submit a job from jupyter server instance
# spark-submit --master spark://spark-master:7077 \
#   --archvies /app/jobs/pyspark_venv.tar.gz \
#   /appjobs/sample.py