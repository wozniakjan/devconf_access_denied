set -e

oc create -f <(cat /root/init/1/pod.yaml <(echo "        path: /home/$USER/pv/1"))
