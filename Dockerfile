FROM ubuntu

RUN apt-get update && apt-get install -y gawk
WORKDIR /tmp/
ENTRYPOINT tools/run.sh
