set -e

# PV mismatch
#
# PV storage capacity and PVC request capacity do not match
# oc get pvc -o yaml > pvc.yaml
# edit request -> capacity
# cat pvc.yaml | oc replace --force -f -
# retry task5

# fs
touch /home/$user/pv/5/file
chown $user /home/$user/pv/5/file
chmod 664 /home/$user/pv/5/file

# SELinux
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/5
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/5/file

# create objects 
oc login -u system:admin 
oc create -f <(cat /root/init/5/pv.yaml | sed "s/\${user}/${user}/g")
oc login -u $user -p $pass
oc create -f <(cat /root/init/5/pvc.yaml | sed "s/\${user}/${user}/g")
oc create -f /root/init/5/pod.yaml
