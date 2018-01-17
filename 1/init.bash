set -e

#fs
touch /home/$user/pv/1/file
chown 1000 /home/$user/pv/1/file

#SELinux
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/1
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/1/file

#create pod
oc create -f <(cat /root/init/1/pod.yaml <(echo "        path: /home/$user/pv/1"))
