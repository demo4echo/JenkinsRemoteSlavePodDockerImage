FROM openjdk:8-jdk-alpine

ENV ENV /root/.profile

ENV GRADLE_VERSION 5.6.4
ENV DOCKER_VERSION 18.06.3-ce
ENV KUBECTL_VERSION 1.17.0
ENV HELM_VERSION 2.16.1
ENV GLIBC_VERSION 2.30-r0

WORKDIR /root

# Update the package manager and install needed utilities/add-ons:
RUN apk update; \
	apk upgrade; \
	apk add curl; \
	apk add git; \
	apk add zip; \
#	apk add docker; \
# Install Gradle:
#	curl -LO https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip; \
#	mkdir /opt/gradle; \
#	unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip; \
#	ln -s /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle /bin/gradle; \
#	rm gradle-${GRADLE_VERSION}-bin.zip; \
# Initialize Gradle wrapper (and trigger Gradle distribution download):
#	mkdir -p /tmp/gradle; \
#	cd /tmp/gradle; \
#	gradle wrapper --no-daemon --gradle-version=${GRADLE_VERSION}; \
#	./gradlew --no-daemon; \
#	cd -;\
#	rm -rf /tmp/gradle; \
# Cleanup Gradle distribution as it is not needed anymore:
#	rm /bin/gradle; \
#	rm -rf /opt/gradle; \
# Install docker client:
	curl -LO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz; \
	mkdir -p /usr/local/sbin; \
	tar xzvf docker-${DOCKER_VERSION}.tgz --strip 1 -C /usr/local/sbin docker/docker; \
	ln -s /usr/local/sbin/docker /bin/docker; \
	rm docker-${DOCKER_VERSION}.tgz; \
# Install kubectl:
	curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl; \
	chmod +x ./kubectl; \
	mv ./kubectl /usr/local/sbin; \
	ln -s /usr/local/sbin/kubectl /bin/kubectl; \
# Install helm:
	curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz; \
	gunzip ./helm-v${HELM_VERSION}-linux-amd64.tar.gz; \
	tar x -vf ./helm-v${HELM_VERSION}-linux-amd64.tar; \
	mv linux-amd64/helm /usr/local/sbin/; \
	ln -s /usr/local/sbin/helm /bin/helm; \
	rm helm-v${HELM_VERSION}-linux-amd64.tar; \
	rm -rf linux-amd64/; \
# Install glibc (Alpine has the musl compiler instead):
	apk --no-cache add ca-certificates wget; \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub; \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk; \
	apk add glibc-${GLIBC_VERSION}.apk; \
	rm glibc-${GLIBC_VERSION}.apk	

# Copy the shell initiation script to the container
COPY ./.profile /root/.profile

LABEL maintainer="tiran.meltser@efrat.com"

LABEL description="A application builder based on: openjdk8, gradle v${GRADLE_VERSION}, docker v${DOCKER_VERSION}, kubectl v${KUBECTL_VERSION}, helm v${HELM_VERSION} and glibc v${GLIBC_VERSION}"
