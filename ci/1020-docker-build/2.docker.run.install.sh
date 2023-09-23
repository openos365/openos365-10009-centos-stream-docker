#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

docker pull quay.io/centos/centos:stream

docker run -i -v ./:/code -w /code quay.io/centos/centos:stream /code/files/install.sh
