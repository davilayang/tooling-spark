FROM spark_base:latest

WORKDIR /app

# TODO: 
# 1. master node and worker node should use different Dockerfile, since master doesn't need Python dependencies
# 2. use Python dependencies by --archives flag

# copy entrypoing script
COPY start-master.sh start-master.sh

# Set up entrypoint and bash
SHELL ["/bin/sh", "-c"]
ENTRYPOINT ["start-master.sh"]
CMD []

