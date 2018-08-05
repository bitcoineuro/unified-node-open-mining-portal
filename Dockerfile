FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y build-essential libssl-dev npm
RUN apt-get install -y git
# Installs below only needed for some testing inside the container
# RUN apt-get install -y curl 
# RUN apt-get install -y iputils-ping
# RUN apt-get install -y net-tools
RUN npm install -g n
RUN n 0.10.25

WORKDIR /opt/
RUN git clone https://github.com/bitcoineuro/unified-node-open-mining-portal.git
WORKDIR /opt/unified-node-open-mining-portal/
RUN npm install
RUN rm coins/*
COPY coins/* coins
COPY pool_configs/* pool_configs
COPY config.json  .

# RUN ln -s /opt/config/config.json /opt/node-open-mining-portal/config.json
# RUN ln -s /opt/config/pool_configs /opt/node-open-mining-portal/pool_configs
# RUN ln -s /opt/config/coins /opt/node-open-mining-portal/coins

EXPOSE 80 3008 3032 3256

CMD node init.js
