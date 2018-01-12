set -e

docker build . -t c1
oc create -f <(cat pod.yaml <(echo "        path: /home/$USER/pv/1"))
