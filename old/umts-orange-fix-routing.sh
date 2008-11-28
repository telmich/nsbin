ip route add 62.65.141.133 dev ppp0
ip route replace default via 62.65.149.150 dev tun1
echo 'search nshq.ch.netstream.com intx.ch.netstream.com netstream.ch' > /etc/resolv.conf
echo nameserver 62.65.128.15 >> /etc/resolv.conf
cp /etc/resolv.conf /home/server/postfix/etc/resolv.conf
