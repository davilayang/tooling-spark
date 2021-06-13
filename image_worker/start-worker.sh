#!/bin/bash

. "$SPARK_HOME/sbin/spark-config.sh"

. "$SPARK_HOME/bin/load-spark-env.sh"

# start worker
ln -sf /dev/stdout $SPARK_HOME/spark-worker.out

$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker \
	--webui-port $SPARK_WORKER_WEBUI_PORT \
	$SPARK_MASTER \
	>> $SPARK_HOME/spark-worker.out


