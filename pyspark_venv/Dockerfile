FROM spark_base:latest

WORKDIR /app 

COPY requirements.txt requirements.txt

COPY build-venv.sh build-venv.sh

RUN chmod +x /app/build-venv.sh

ENTRYPOINT /app/build-venv.sh