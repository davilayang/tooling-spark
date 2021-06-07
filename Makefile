SHELL=/bin/bash

# build base image
build-base:
	docker build ./image_base -t spark_base:latest	

# build the venv for Python dependencies
build-venv: 
	

# build the cluster
build: build-base
	docker-compose build 

# start the spark cluster (also build)
start:
	docker-compose up

restart: start

# start the spark cluster in detached mode
start-detach: 
	docker-compose up --detach

restart-detach: start-detach 

# stop the spark cluster 
stop: 
	docker-compose stop

# stop the Spark cluster and remove all volumes
down: 
	docker-compose down --volumes