#!/bin/bash

. "$SPARK_HOME/sbin/spark-config.sh"

. "$SPARK_HOME/bin/load-spark-env.sh"

# start master
export SPARK_MASTER_HOST=$HOSTNAME
ln -sf /dev/stdout $SPARK_HOME/spark-master.out

$SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master \
	--ip $SPARK_MASTER_HOST \
	--port $SPARK_MASTER_PORT \
	--webui-port $SPARK_MASTER_WEBUI_PORT \
	>> $SPARK_HOME/spark-master.out
