SHELL=/bin/bash

# build the venv for Python dependencies
build-venv: 
	python -m venv --copies pyspark_venv
	./pyspark_venv/bin/pip install -r requirements.txt
	./pyspark_venv/bin/venv-pack --force -p ./pyspark_venv/ -o ./mounted_dirs/jobs/pyspark_venv.tar.gz
	rm -fr pyspark_venv/

# copy requirements.txt for jupyter server
copy-req:
	cp ./requirements.txt ./image_jupyter/requirements.txt

# build the cluster
build: build-venv copy-req
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