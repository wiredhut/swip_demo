#!/bin/bash
#Deploy to ECR script

while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG};;
    esac
done

if [[ -z $version ]]
    then
        echo "version (-v parameters) required"
        return 1
fi

REGION=eu-west-1
ECR=751768488034.dkr.ecr.eu-west-1.amazonaws.com
REPOSITORY=swip_demo
DOCKERFILE=./Dockerfile

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR
docker build -f $DOCKERFILE -t $REPOSITORY .

docker tag $REPOSITORY:latest $ECR/$REPOSITORY:latest
docker push $ECR/$REPOSITORY:latest

docker tag $REPOSITORY:latest $ECR/$REPOSITORY:$version
docker push $ECR/$REPOSITORY:$version

