FROM spark_base:latest

# TODO: 
# 1. master node and worker node should use different Dockerfile, since master doesn't need Python dependencies
# 2. use Python dependencies by --archives flag

# Copy entrypoing script
COPY start-worker.sh start-worker.sh

# prepare worker dependencies
# COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt

# Set up entrypoint and bash
SHELL ["/bin/sh", "-c"]
ENTRYPOINT ["start-worker.sh"]
CMD []

