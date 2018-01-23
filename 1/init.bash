set -e

# Group permissions mismatch
#
# the container tries to write to 644 file
# has matching GID but not matching UID as underlying system
# simple fix is to change permissions to 664
# 
# chmod 664 /home/$user/pv/1/file

# fs
touch /home/$user/pv/1/file
chown $user /home/$user/pv/1/file

# SELinux
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/1
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/1/file

# create pod
oc create -f <(cat /root/init/1/pod.yaml <(echo "        path: /home/$user/pv/1"))
