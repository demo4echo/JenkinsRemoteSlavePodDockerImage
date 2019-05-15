FROM openjdk:8-jdk-alpine

ENV DOCKER_VERSION 18.06.3-ce
ENV KUBECTL_VERSION v1.14.1
ENV HELM_VERSION v2.13.1

WORKDIR /root

# Update the package manager and install curl:
RUN apk update; \
	apk upgrade; \
	apk add curl; \
# Install docker:
	curl -LO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz; \
	mkdir -p /usr/local/sbin; \
	tar xzvf docker-${DOCKER_VERSION}.tgz --strip 1 -C /usr/local/sbin docker/docker; \
	ln -s /usr/local/sbin/docker /bin/docker; \
	rm docker-${DOCKER_VERSION}.tgz; \
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
	rm -rf linux-amd64/

# These 2 will be copied during the build process itself in Jenkins Pipeline
#COPY ./.docker/ ./.docker/
#COPY ./.kube/ ./.kube/

CMD ["/bin/sh"]

LABEL maintainer="tiran.meltser@efrat.com"
LABEL description="A docker image with JDK, docker client, kubectl client and helm client"
