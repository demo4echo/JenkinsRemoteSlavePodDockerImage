@echo off

@REM Build the image
docker build -t alpine_openjdk8_k8scdk .

@REM Tag the image
docker tag alpine_openjdk8_k8scdk demo4echo/alpine_openjdk8_k8scdk

@REM Push the image
docker push demo4echo/alpine_openjdk8_k8scdk
