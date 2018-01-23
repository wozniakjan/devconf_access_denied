set -e

# SELinux missing completely
#
# chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/4
# chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/4/file

# fs
touch /home/$user/pv/4/file
chown $user /home/$user/pv/4/file
chmod 664 /home/$user/pv/4/file

# create pod
oc create -f <(cat /root/init/4/pod.yaml <(echo "        path: /home/$user/pv/4"))
