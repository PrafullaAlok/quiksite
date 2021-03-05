#!/usr/bin/env bash

function usage()
{
  echo "Usage: create-quiksite.sh -c company_name -e dev,qa,prod"
  echo "You can use either one or all environments from dev,qa and prod"
}

while getopts c:e: flag
do
    case "${flag}" in
        c) companyname=${OPTARG};;
        e) environment=${OPTARG};;
    esac
done

echo "Company_name: $companyname";
echo "Environment/s: $environment";

[ -z "$companyname" ] && usage && exit 1
[ -z "$environment" ] && usage && exit 1
