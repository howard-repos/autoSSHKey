#!/bin/bash

# set env
if [ $# -eq 0 ];then
	echo "usage :$0 <password>"
	exit 1
fi
PASSWD=$1
WORK_DIR=$(cd `dirname $0`; pwd)
cd $WORK_DIR
. $WORK_DIR/conf.sh
MASTER_HOSTNAME=$(hostname)

# check key file
if [ ! -f ~/.ssh/id_rsa ];then
	echo "no ssh key found,will use ssh-keygen -f ~/.ssh/id_rsa -N \"\" to generate one"
	ssh-keygen -f ~/.ssh/id_rsa -N ""
fi


echo 
echo
echo "============checking ssh key============"
echo 
echo
for node in ${WORKERS_HOSTNAME[@]};do
	echo "installing ssh key to $node"
	./tools/ssh-expect.sh $node $PASSWD
done
echo "installing ssh key to $MASTER_HOSTNAME"
./tools/ssh-expect.sh $MASTER_HOSTNAME $PASSWD
