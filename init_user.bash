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

user=""
while true ; do
    case "$1" in
        -u|--user) export user="$2" ; shift 2 ;;
        -p|--password) export pass="$2" ; shift 2 ;;
        -h|--help) usage ; shift 1 ;;
        --) shift ; break ;;
        *) usage ; exit 1 ;;
    esac
done

if [[ -z $user ]]; then
	usage
	exit 1
fi
if [[ -z $pass ]]; then
    export pass=$user	
fi

info "adding user $user"
useradd -g users -d /home/$user -s /bin/bash -p $(echo  $pass | openssl passwd -1 -stdin) $user

info "initializing oc user and project"
htpasswd -b /root/pwd $user $pass
oc login -u $user -p $pass 
oc new-project ${user}-project 
oc login -u system:admin 
oc adm policy add-scc-to-user hostaccess $user
oc adm policy add-cluster-role-to-user scc-editor $user
oc adm policy add-cluster-role-to-user scc-editor2 $user
oc adm policy add-cluster-role-to-user pv-view $user
oc login -u $user -p $pass
su -c "oc login devconf:8443 -u $user -p $pass" - $user

info "initializing tasks"
mkdir -p /home/$user/pv/{1..5} 
for f in {1..5}; do
    /root/init/$f/init.bash 
done
