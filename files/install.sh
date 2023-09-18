#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
export TERM=xterm-256color
echo $PROJECT_NAME
cd $CMD_PATH
env

whoami
pwd
dnf --assumeyes install perl 
dnf --assumeyes install rsync

rsync -avzP ./root/ /

update_mirror.pl /etc/yum.repos.d/centos*.repo

dnf clean all
dnf makecache

dnf --assumeyes install epel-release dnf-plugins-core
dnf --assumeyes upgrade epel-release
crb enable

dnf --assumeyes install kiwi 
dnf --assumeyes install sudo

cd ~
mkdir versions
cd versions
dnf list installed > dnf.list.installed.txt
dnf list > dnf.list.txt

