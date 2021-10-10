package my.example.pi_compute
package my.example.pi_compute

import org.apache.spark.sql.SparkSession


// singleton, invoked at most once
object PiComputeScalaExample {


    def main(args: Array[String]): Unit = {

      val NUM_SAMPLES: Int = 100000

      val spark = SparkSession.builder
                    .appName("Spark Pi Compute")
                    .master("spark://localhost:7077")
                    .getOrCreate

      val count = spark.sparkContext.parallelize(1 to NUM_SAMPLES).filter {
        _ => 
          val x = math.random
          val y = math.random

          x * x + y * y < 1
      }.count()

      println(s"Pi is roughly ${4.0 * count / NUM_SAMPLES}")

    }
}