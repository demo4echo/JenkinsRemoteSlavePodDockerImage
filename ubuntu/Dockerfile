FROM ubuntu

ENV ENV /root/.profile

ENV JDK_SDKMAN_VERSION 8.0.242.j9-adpt
ENV GRADLE_VERSION 5.6.4
ENV DOCKER_VERSION 18.06.3-ce
ENV KUBECTL_VERSION 1.17.0
ENV HELM_VERSION 2.16.1

WORKDIR /root

SHELL ["bash","-c"]

# Update the package manager and install needed utilities/add-ons:
RUN apt-get update -y -qq; \
	apt-get install curl -y -qq; \
	apt-get install git -y -qq; \
	apt-get install zip -y -qq; \
#	apt-get install docker -y -qq; \
# Install SDK Manager (sdkman):
	curl -s "https://get.sdkman.io" | bash; \
	source "$HOME/.sdkman/bin/sdkman-init.sh"; \
# Install JDK (with sdkman):
	sdk install java ${JDK_SDKMAN_VERSION}; \
# Install Gradle (with sdkman):
	sdk install gradle ${GRADLE_VERSION}; \
# Initialize Gradle wrapper (and trigger Gradle distribution download):
	gradle wrapper --no-daemon --gradle-version=${GRADLE_VERSION}; \
	./gradlew --no-daemon; \
# Cleanup Gradle distribution as it is not needed anymore:
	sdk uninstall gradle ${GRADLE_VERSION}; \
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
	rm -rf linux-amd64/

# Copy the shell initiation script to the container
COPY ./.profile /root/.profile

# Add workaround since sdkman handles only bash and zsh shells, but not sh!
# Note: this line must come after the .profile file has been copied to the image!
RUN  echo JAVA_HOME=$JAVA_HOME >> /root/.profile

LABEL maintainer="tiran.meltser@efrat.com"

LABEL description="A application builder based on: JDK v${JDK_SDKMAN_VERSION}, gradle v${GRADLE_VERSION}, docker v${DOCKER_VERSION}, kubectl v${KUBECTL_VERSION} and helm v${HELM_VERSION}"
