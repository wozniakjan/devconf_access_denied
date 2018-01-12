#!/bin/bash

set -e

trap 'echo done; oc login -u system:admin > /dev/null; cd ~/init > /dev/null' 'EXIT' 

usage() {
    echo "Usage: [-u|--user=<.*>] [-h|--help]"
}

info() { 
	echo "$@" 1>&2; 
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

info "adding user $USER"
useradd -g users -d /home/$USER -s /bin/bash -p $(echo  $USER | openssl passwd -1 -stdin) $USER

info "initializing oc user and project"
oc login -u $USER -p $USER 
oc new-project ${USER}-project 
oc login -u system:admin 
oc adm policy add-scc-to-user hostaccess $USER
oc login -u $USER -p $USER 

info "initializing fs"
mkdir -p /home/$USER/pv/{1..15} 
for f in {1..15}; do
    /root/init/$f/init.bash 

done

info "creating oc objects"
for f in {1..15}; do
    cd /root/init/$f 
    ./oc_init.bash 
    cd - 
done
