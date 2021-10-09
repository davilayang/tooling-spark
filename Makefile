SHELL=/bin/bash

# build base image
build-base:
	docker build ./image_base -t spark_base:latest	

# copy Python requirements to related services
copy-req:
	cp ./requirements.txt ./image_jupyter/requirements.txt
	cp ./requirements.txt ./pyspark_venv/requirements.txt

# build the cluster
build: build-base copy-req
	docker-compose build 

# start the spark cluster 
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

# stop the Spark cluster and remove all volumes and containers
down: 
	docker-compose down --volumes

remove-containers:
	docker container rm $(docker ps --all --quiet --filter label=cluster=spark)

remove-images: 
	docker rmi $(docker images --quiet --filter "label=cluster=spark")