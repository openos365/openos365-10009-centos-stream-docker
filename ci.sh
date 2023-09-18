#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

ssh-keygen -f "/home/runner/.ssh/known_hosts" -R "frs.sourceforge.net"
ssh-keyscan "frs.sourceforge.net" >> /home/runner/.ssh/known_hosts
ssh-keygen -f "/home/runner/.ssh/known_hosts" -R "github.com"
ssh-keyscan "github.com" >> /home/runner/.ssh/known_hosts
cat /home/runner/.ssh/known_hosts


env

cd $CMD_PATH
docker build . -f Dockerfile \
-t ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest \
-t gnuhub/$PROJECT_NAME-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t gnuhub/$PROJECT_NAME-$GITHUB_REF_NAME:latest \
-t hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest \
-t registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest


docker push ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
docker push ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest
docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER 
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest 
docker push gnuhub/$PROJECT_NAME-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
docker push gnuhub/$PROJECT_NAME-$GITHUB_REF_NAME:latest

# cd ~/
# git clone git@github.com:archlinux365/9996-ubuntu-docker.git

# cd 9996-ubuntu-docker

# rm -rf versions 

# cid=$(docker run -it --detach registry.cn-hangzhou.aliyuncs.com/archlinux365/9996-ubuntu-docker-runner:latest)
# docker cp ${cid}:/home/runner/versions/ ./versions/

# git config --global user.email "gnuhub@gmail.com"
# git config --global user.name "gnuhub"
# git add .
# git commit -a -m "CI-BOT:$(date +%Y.%m.%d-%H%M%S)-$GITHUB_REF_NAME-$GITHUB_RUN_NUMBER"
# git push origin HEAD
