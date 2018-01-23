set -e

#visudo %users  ALL=(root)      NOPASSWD: /usr/bin/chcon

oc create clusterrole scc-editor --verb=create,delete,get,list,update,watch --resource=securitycontextconstraints
oc create clusterrole scc-editor2 --verb=create,delete,get,list,update,watch --resource=securitycontextconstraints.security.openshift.io

./init_docker.bash

./init_user.bash -u devconf1 -p 5be4c7
#./init_user.bash -u devconf2 -p c5981f
#./init_user.bash -u devconf3 -p 9b674f
#./init_user.bash -u devconf4 -p 7a90d3
#./init_user.bash -u devconf5 -p e56657
#./init_user.bash -u devconf6 -p 5db6c4
#./init_user.bash -u devconf7 -p b9f05c
#./init_user.bash -u devconf8 -p 54f05e
#./init_user.bash -u devconf9 -p cebb66
#./init_user.bash -u devconf10 -p 886221
