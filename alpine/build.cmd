@echo off

SET REPOSITORY_NAME="demo4echo"
SET IMAGE_NAME="alpine_openjdk8_k8scdk"
SET IMAGE_TAG="latest"

@REM Build the image
docker build -t %IMAGE_NAME%:%IMAGE_TAG% .

@REM Tag the image
docker tag %IMAGE_NAME%:%IMAGE_TAG% %REPOSITORY_NAME%/%IMAGE_NAME%:%IMAGE_TAG%

@REM Push the image
docker push %REPOSITORY_NAME%/%IMAGE_NAME%:%IMAGE_TAG%
