set -e

# Service Account missing permissions
#
# oc adm policy add-scc-to-user hostmount-anyuid system:serviceaccount:${user}-project:default

# fs
touch /home/$user/pv/2/file
chown $user /home/$user/pv/2/file
chmod 664 /home/$user/pv/2/file

# SELinux
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/2
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/2/file

# create dc 
oc create -f <(cat /root/init/2/dc.yaml <(echo "          path: /home/$user/pv/2"))
