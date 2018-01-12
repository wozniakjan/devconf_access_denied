#!/bin/bash

set -e

trap 'echo done; oc login -u system:admin > /dev/null; cd ~/init > /dev/null' 'EXIT' 

usage() {
    echo "Usage: [-u|--user=<.*>] [-h|--help]"
}

TEMP=`getopt -o u:h --long user:,help -n 'init' -- "$@"`
eval set -- "$TEMP"

USER=""
while true ; do
    case "$1" in
        -u|--user) export USER="$2" ; shift 2 ;;
        -h|--help) usage ; shift 1 ;;
        --) shift ; break ;;
        *) usage ; exit 1 ;;
    esac
done

if [[ -z $USER ]]; then
	usage
	exit 1
fi

echo "adding user $USER"
useradd -g users -d /home/$USER -s /bin/bash -p $(echo  $USER | openssl passwd -1 -stdin) $USER > /tmp/log_$USER.txt

echo "initializing oc user and project"
oc login -u $USER -p $USER >> /tmp/log_$USER.txt
oc new-project ${USER}-project >> /tmp/log_$USER.txt

echo "initializing fs"
mkdir -p /home/$USER/pv/{1..15} >> /tmp/log_$USER.txt
for f in {1..15}; do
    /root/init/$f/init.bash >> /tmp/log_$USER.txt

done

echo "creating oc objects"
for f in {1..15}; do
    cd /root/init/$f >> /tmp/log_$USER.txt
    ./oc_init.bash >> /tmp/log_$USER.txt
    cd - >> /tmp/log_$USER.txt
done
