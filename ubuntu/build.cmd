@echo off

SET REPOSITORY_NAME="demo4echo"
SET IMAGE_NAME="ubuntu_k8scdk"
SET IMAGE_TAG="latest"

@REM Copy needed files from outside the build space
COPY ..\.profile .

@REM Build the image
docker build -t %IMAGE_NAME%:%IMAGE_TAG% .

@REM CDo some cleanup
DEL .profile

@REM Tag the image
rem docker tag %IMAGE_NAME%:%IMAGE_TAG% %REPOSITORY_NAME%/%IMAGE_NAME%:%IMAGE_TAG%

@REM Push the image
rem docker push %REPOSITORY_NAME%/%IMAGE_NAME%:%IMAGE_TAG%
