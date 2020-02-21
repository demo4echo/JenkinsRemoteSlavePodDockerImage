FROM openjdk:8-jdk-alpine

ENV DOCKER_VERSION 18.06.3-ce
ENV KUBECTL_VERSION v0.17.0
ENV HELM_VERSION v2.16.1
ENV GLIBC_VERSION 2.30-r0
ENV ENV /root/.profile

WORKDIR /root

# Update the package manager and install curl:
RUN apk update; \
	apk upgrade; \
	apk add curl; \
	apk add git; \
# Install docker client (and daemon), jumpstart the daemon, and run a sanity test:
	curl -LO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz; \
	mkdir -p /usr/local/sbin; \
	tar xzvf docker-${DOCKER_VERSION}.tgz --strip 1 -C /usr/local/sbin docker/*; \
	ln -s /usr/local/sbin/docker /bin/docker; \
	ln -s /usr/local/sbin/dockerd /bin/dockerd; \
	rm docker-${DOCKER_VERSION}.tgz; \
	/bin/dockerd &; \
	/bin/docker run hello-world; \
# Install kubectl:
	curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl; \
	chmod +x ./kubectl; \
	mv ./kubectl /usr/local/sbin; \
	ln -s /usr/local/sbin/kubectl /bin/kubectl; \
# Install helm:
	curl -LO https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz; \
	gunzip ./helm-${HELM_VERSION}-linux-amd64.tar.gz; \
	tar x -vf ./helm-${HELM_VERSION}-linux-amd64.tar; \
	mv linux-amd64/helm /usr/local/sbin/; \
	ln -s /usr/local/sbin/helm /bin/helm; \
	rm helm-${HELM_VERSION}-linux-amd64.tar; \
	rm -rf linux-amd64/; \
# Install glibc (Alpine has the musl compiler instead):
	apk --no-cache add ca-certificates wget; \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub; \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk; \
	apk add glibc-${GLIBC_VERSION}.apk; \
	rm glibc-${GLIBC_VERSION}.apk	

# These 2 will be copied during the build process itself in Jenkins Pipeline
#COPY ./.docker/ ./.docker/
#COPY ./.kube/ ./.kube/

# Copy the shell initiation script to the container
COPY ./.profile /root/.profile

CMD ["/bin/sh"]

LABEL maintainer="tiran.meltser@efrat.com"
LABEL description="A docker image with JDK, docker client, kubectl client and helm client"
