#nm-connection-editor - sets SSID to hostname, hostnamectl set-hostname 'whatever SSID wants'
#/etc/sysconfig/network-scripts/ifcfg-Hotspot
#iptables -t nat -I PREROUTING -p tcp -d 10.34.129.64 --dport 22 -j DNAT --to-destination 192.168.122.129:22
#iptables -t nat -I PREROUTING -i enp0s31f6 -p tcp --dport 22 -j DNAT --to 192.168.122.129:22
#iptables -t nat -I PREROUTING -i lo -p tcp --dport 22 -j DNAT --to 192.168.122.129:22
#iptables -t nat -I PREROUTING -p tcp -d 192.168.0.192 --dport 22 -j DNAT --to-destination 192.168.122.129:22
iptables -t nat -I PREROUTING -p tcp -d 10.42.0.1 --dport 22 -j DNAT --to-destination 192.168.122.129:22
iptables -I FORWARD -m state -d 192.168.122.129 --state NEW,RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -p tcp -d 192.168.122.129 --dport 22 -j ACCEPT
