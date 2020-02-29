# JenkinsRemoteSlavePodDockerImage
_A module dealing with **docker** images used as Jenkins Slave **Pods** for building the µs :bowtie:_

## TL;DR:
The module generate **docker** images (used as Jenkins Slave **Pods**) containing all necessary build tools (e.g. JDK, docker client, kubectl client, helm client, and so on). The images come in 2 flavors:
- Alpine
- Ubuntu

_**Note**_: The image doesn't contain a **Groovy** installation as the **Groovy** wrapper will download the needed **Gradle** upon first execution.
