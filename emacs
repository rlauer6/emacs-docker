#!/usr/bin/env bash
# -*- mode: sh; -*-
# run emacs as user

TAG=${TAG:-emacs}
ENTRY_POINT=${ENTRY_POINT:-emacs}

ID=${1:-$(id -u)}
VERSION=${2:-latest}

AWS_REGION=${AWS_REGION:-us-east-1}

AWS_ECR_URL="dkr.ecr.$AWS_REGION.amazonaws.com"

AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r .Account)

REPO_URL_BASE="$AWS_ACCOUNT.$AWS_ECR_URL"

IMAGE_NAME="$REPO_URL_BASE/$TAG:$VERSION"

if docker image list | grep "$IMAGE_NAME"; then
    docker login $REPO_URL_BASE
fi

docker run -it --rm  -u $ID \
       -e HOME=$HOME \
       -e TERM=xterm-256color \
       -e TZ=US/Eastern \
       -v $HOME:$HOME \
       $IMAGE_NAME $ENTRY_POINT
