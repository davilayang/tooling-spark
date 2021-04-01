#!/bin/bash

export SPARK_LOG_DIR=$SPARK_HOME/logs

. "$SPARK_HOME/sbin/spark-config.sh"

. "$SPARK_HOME/bin/load-spark-env.sh"

mkdir -p $SPARK_LOG_DIR


# start master
if [[ $SPARK_TYPE == "master" ]]; then
    echo "starting master instance"

    export SPARK_MASTER_HOST=$HOSTNAME

    ln -sf /dev/stdout $SPARK_LOG_DIR/spark-master.out

    $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master \
        --ip $SPARK_MASTER_HOST \
        --port $SPARK_MASTER_PORT \
        --webui-port $SPARK_MASTER_WEBUI_PORT \
        >> $SPARK_LOG_DIR/spark-master.out

# start worker
else
    echo "starting worker instance"

    ln -sf /dev/stdout $SPARK_LOG_DIR/spark-worker.out

   $SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker \
        --webui-port $SPARK_WORKER_WEBUI_PORT \
        $SPARK_MASTER \
        >> $SPARK_LOG_DIR/spark-worker.out

fi


