set -e

# PV mismatch
#

# fs
touch /home/$user/pv/5/file
chown $user /home/$user/pv/5/file
chmod 664 /home/$user/pv/5/file

# SELinux
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/5
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/5/file

# create objects
oc create -f <(cat /root/init/5/pv.yaml <(echo "    path: /home/$user/pv/5"))
oc create -f <(cat /root/init/5/pvc.yaml)
oc create -f <(cat /root/init/5/pod.yaml)
