#!/bin/bash

set -e

trap 'echo done; oc login -u system:admin > /dev/null; cd ~/init > /dev/null' 'EXIT' 

usage() {
    echo "Usage: [-u|--user=<.*>] [-p|--password=<.*>] [-h|--help]"
}

info() { 
	echo "$@" 1>&2; 
}

TEMP=`getopt -o u:p:h --long user:,password:,help -n 'init' -- "$@"`
eval set -- "$TEMP"

USER=""
while true ; do
    case "$1" in
        -u|--user) export USER="$2" ; shift 2 ;;
        -p|--password) export PASSWORD="$2" ; shift 2 ;;
        -h|--help) usage ; shift 1 ;;
        --) shift ; break ;;
        *) usage ; exit 1 ;;
    esac
done

if [[ -z $USER ]]; then
	usage
	exit 1
fi
if [[ -z $PASSWORD ]]; then
    PASSWORD=$USER	
fi

info "adding user $USER"
useradd -g users -d /home/$USER -s /bin/bash -p $(echo  $PASSWORD | openssl passwd -1 -stdin) $USER

info "initializing oc user and project"
htpasswd -b /root/pwd $USER $PASSWORD
oc login -u $USER -p $PASSWORD 
oc new-project ${USER}-project 
oc login -u system:admin 
oc adm policy add-scc-to-user hostaccess $USER
oc login -u $USER -p $PASSWORD 

info "initializing tasks"
mkdir -p /home/$USER/pv/{1..15} 
for f in {1..15}; do
    /root/init/$f/init.bash 
done
