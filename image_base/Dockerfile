FROM python:3.8.10-buster

WORKDIR /app

# install python, for Spark and Jupyter
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    openjdk-11-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

# config prompt for root (escape \n with \\\n)
RUN echo "PS1='\[\e[0;37m\][\w]\\\n\[\e[0;35m\]\u\[\e[1;34m\]@🐳\[\e[1;36m\]\h\[\e[1;34m\] ❯ \[\e[0m\]'" \
    >> /etc/bash.bashrc && \
    echo "set bell-style none" >> /etc/inputrc

# Fix the value of PYTHONHASHSEED
ENV PYTHONHASHSEED 1

# reset entrypoint 
SHELL ["/bin/sh", "-c"]
ENTRYPOINT []
CMD ["bash"]


# docker build ./image_base -t local/spark-base:latest
