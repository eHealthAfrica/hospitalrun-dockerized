FROM ubuntu:latest

RUN apt-get update

RUN apt-get install nodejs -y
RUN apt-get install npm -y
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get install git -y

RUN npm install --no-bin-links
RUN npm install -g ember-cli
RUN npm install -g bower

RUN git clone https://github.com/HospitalRun/hospitalrun-frontend.git

WORKDIR /hospitalrun-frontend

RUN npm install
RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN bower install

RUN cp server/config-example.js server/config.js

RUN apt-get update
RUN apt-get install curl

EXPOSE 4200
CMD ./script/initcouch.sh && ember serve
