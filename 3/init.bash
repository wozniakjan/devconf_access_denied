set -e

# SElinux securityContext level and categories missing
#
# oc adm policy add-scc-to-user privileged system:serviceaccount:${user}-project:default
# oc edit deployment
#   securityContext:
#     seLinuxOptions:
#       level: "s0:c0,c5"
#
# or
#
# chcat -- -c0 /home/$user/pv/3
# chcat -- -c5 /home/$user/pv/3

# fs
touch /home/$user/pv/3/file
chown $user /home/$user/pv/3/file
chmod 664 /home/$user/pv/3/file

# SELinux
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/3
chcon -u system_u -r object_r -t svirt_sandbox_file_t /home/$user/pv/3/file
chcat -- +c0 /home/$user/pv/3
chcat -- +c5 /home/$user/pv/3

# create dc 
oc create -f <(cat /root/init/3/dc.yaml <(echo "          path: /home/$user/pv/3"))
