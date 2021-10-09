#!/bin/bash

# build python virtual environment

python -m venv pyspark_venv

./pyspark_venv/bin/pip install -r requirements.txt venv-pack 

./pyspark_venv/bin/python -m pip install --upgrade pip

# export the dependencies as tar.gz archive

./pyspark_venv/bin/venv-pack --force \
  --prefix ./pyspark_venv/ \
  --output /app/jobs/pyspark_venv.tar.gz

# change archive permission to allow reading by any
chmod a+r /app/jobs/pyspark_venv.tar.gz