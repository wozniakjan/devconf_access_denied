set -e

touch /home/$USER/pv/1/file
chown 1001 /home/$USER/pv/1/file

oc create -f <(cat /root/init/1/pod.yaml <(echo "        path: /home/$USER/pv/1"))
