# /bin/bash

# build the cluster
build: 
	docker-compose build 

# start the spark cluster (also build)
start: 
	docker-compose up --build

# start the spark cluster in detached mode
start-detach: 
	docker-compose up --build --detach

# stop the spark cluster and remove all created volumes
stop: 
	docker-compose down --volumes

