#!/usr/bin/env bash
if [ -z "$1" ]
then
  echo "Usage: run.sh [dev|qa|prod]"
  exit 1
fi

if [ $1 != "dev" ] && [ $1 != "qa" ] && [ $1 != "prod" ]
then
  echo "Usage: run.sh [dev|qa|prod]"
  exit 1
fi

#Check if AWS env is set
missing_env=0

if [ -z "${AWS_ACCESS_KEY_ID}" ]
then
  echo "Please set the AWS_ACCESS_KEY_ID env variable."
  missing_env=1
fi

if [ -z "${AWS_SECRET_ACCESS_KEY}" ]
then
  echo "Please set the AWS_SECRET_ACCESS_KEY env variable."
  missing_env=1
fi

if [ -z "${AWS_REGION}" ]
then
  echo "Please set the AWS_REGION env variable."
  missing_env=1
fi

if [ ${missing_env} = 1 ]
then
  exit 1
fi

OLD_DIR=`pwd`
cd `dirname $BASH_SOURCE` # $BASH_SOURCE gives the relative path of this file
RUN_DIR=`pwd`/../
echo "RUN_DIR: ${RUN_DIR}"
cd ${RUN_DIR}

docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_REGION -v ${RUN_DIR}:/opt/projects/quiksite/terraform -v ${RUN_DIR}/deployments/${1}.tf:/opt/projects/quiksite/terraform/main.tf -w /opt/projects/quiksite/terraform hashicorp/terraform init
docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_REGION -v ${RUN_DIR}:/opt/projects/quiksite/terraform -v ${RUN_DIR}/deployments/${1}.tf:/opt/projects/quiksite/terraform/main.tf -w /opt/projects/quiksite/terraform hashicorp/terraform plan
echo "Done"
cd ${OLD_DIR}
