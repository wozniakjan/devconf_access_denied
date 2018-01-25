set -e

#visudo %users  ALL=(root)      NOPASSWD: /usr/bin/chcon, /usr/bin/chcat
#/etc/origin/node/node-config.yaml
#kubeletArguments:
#  pods-per-core:
#    - "100"

oc create clusterrole scc-editor --verb=create,delete,get,list,update,watch --resource=securitycontextconstraints
oc create clusterrole scc-editor2 --verb=create,delete,get,list,update,watch --resource=securitycontextconstraints.security.openshift.io
oc create clusterrole pv-view --verb=get,list --resource=persistentvolumes

./init_docker.bash

./init_user.bash -u devconf1 -p 5be4c7
./init_user.bash -u devconf2 -p c5981f
./init_user.bash -u devconf3 -p 9b674f
./init_user.bash -u devconf4 -p 7a90d3
./init_user.bash -u devconf5 -p e56657
./init_user.bash -u devconf6 -p 5db6c4
./init_user.bash -u devconf7 -p b9f05c
./init_user.bash -u devconf8 -p 54f05e
./init_user.bash -u devconf9 -p cebb66
./init_user.bash -u devconf10 -p 886221
./init_user.bash -u devconf11 -p f7a81e 
./init_user.bash -u devconf12 -p 5fd87e
./init_user.bash -u devconf13 -p 1add4d
./init_user.bash -u devconf14 -p 75aa38
./init_user.bash -u devconf15 -p 2cdd85
./init_user.bash -u devconf16 -p e741c6
./init_user.bash -u devconf17 -p 1dda8b
./init_user.bash -u devconf18 -p 426869
./init_user.bash -u devconf19 -p 932292
./init_user.bash -u devconf20 -p 4cf336
./init_user.bash -u devconf21 -p 579c21
./init_user.bash -u devconf22 -p dfc2f5
./init_user.bash -u devconf23 -p 35afbb
./init_user.bash -u devconf24 -p 04cf99
./init_user.bash -u devconf25 -p 73d238
./init_user.bash -u devconf26 -p 2ac050
./init_user.bash -u devconf27 -p 324f8a
./init_user.bash -u devconf28 -p 009648
./init_user.bash -u devconf29 -p ea1d4f
./init_user.bash -u devconf30 -p c112cc
