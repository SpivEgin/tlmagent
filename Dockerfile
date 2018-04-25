from debian:stretch-slim

ENV COMPOSE_VERSION=1.20.0

RUN mkdir /opt/docker /opt/docker/docker-compose

# Files from the source
#ADD https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-Linux-x86_64 /opt/docker/docker-compose/
#ADD https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce_18.03.0~ce-0~debian_amd64.deb /opt/install/docker-ce.deb

# Files local
ADD files/docker-compose-Linux-x86_64 /opt/docker/docker-compose/
ADD files/docker-ce_18.03.0~ce-0~debian_amd64.deb /opt/install/docker-ce.deb
RUN apt-get update &&\
    apt-get install -y iptables libdevmapper1.02.1  libltdl7 libseccomp2 &&\
    dpkg -i /opt/install/docker-ce.deb &&\
    mv /opt/docker/docker-compose/docker-compose-Linux-x86_64 /opt/docker/docker-compose/docker-compose &&\
    chmod +x /opt/docker/docker-compose/docker-compose &&\
    ln -s /opt/docker/docker-compose/docker-compose /bin/docker-compose &&\
    rm -rf /opt/install &&\     
    apt-get -y autoclean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    