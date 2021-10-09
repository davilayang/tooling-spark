FROM local/spark-base:latest

WORKDIR /app 

COPY requirements.txt requirements.txt

# build python virtual environment

RUN python -m venv pyspark_venv

RUN ./pyspark_venv/bin/python -m pip install --upgrade pip &&\
  ./pyspark_venv/bin/pip install -r requirements.txt venv-pack 

# export the dependencies as tar.gz archive

RUN ./pyspark_venv/bin/venv-pack --force \
  --prefix ./pyspark_venv/ \
  --output /app/pyspark_venv.tar.gz

# change archive permission to allow reading by any
RUN chmod a+r /app/pyspark_venv.tar.gz

# copy to the mounted volume when starting the cluster
