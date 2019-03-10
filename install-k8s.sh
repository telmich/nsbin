#!/bin/sh

while [ $# -ge 1 ]; do
    host="$1"; shift
    echo "Installing on $host ..."
    ssh root@$host "
    apt-get update && apt-get install -y apt-transport-https curl;
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -;
    cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF"
    ssh root@$host "apt-get update; apt-get install -y kubeadm kubectl; apt-mark hold kubelet kubeadm kubectl"
    ssh root@$host "apt-get install -y docker.io && systemctl enable docker.service"
    ssh root@$host "echo net.ipv6.conf.all.forwarding=1 > /etc/sysctl.conf; sysctl -p"
done
