FROM golang:latest
COPY build_jp.sh ./
RUN ./build_jp.sh

COPY aws /opt/projects/aws
RUN /opt/projects/aws/install -i /usr/local/aws-cli -b /usr/local/bin
