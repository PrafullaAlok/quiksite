#!/usr/bin/env bash
if [ -z "$1" ]
then
  echo "Usage: run-once.sh [dev|qa|prod]"
  exit 1
fi

if [ $1 != "dev" ] && [ $1 != "qa" ] && [ $1 != "prod" ]
then
  echo "Usage: run-once.sh [dev|qa|prod]"
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
RUN_ONCE_DIR=`pwd`/../deployments/${1}-run-once
echo "RUN_ONCE_DIR: ${RUN_ONCE_DIR}"
cd ${RUN_ONCE_DIR}

docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_REGION -v ${RUN_ONCE_DIR}:/opt/projects/quiksite/terraform -w /opt/projects/quiksite/terraform hashicorp/terraform init
docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_REGION -v ${RUN_ONCE_DIR}:/opt/projects/quiksite/terraform -w /opt/projects/quiksite/terraform hashicorp/terraform apply -auto-approve
echo "Done"
cd ${OLD_DIR}
