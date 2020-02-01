# Layer Two Tunneling Protocol (L2TP) IPSEC Server
wget https://git.io/vpnsetup -O vpnsetup.sh && sudo \
VPN_IPSEC_PSK=$YOUR_IPSEC_PSK \
VPN_USER=$YOUR_USERNAME \
VPN_PASSWORD=$YOUR_PASSWORD sh vpnsetup.sh

# Point to point (PPTP) Server
apt-get install pptpd -y
echo "localip 10.0.0.1" >> /etc/pptpd.conf
echo "remoteip 10.0.0.100-200" >> /etc/pptpd.conf
echo "$YOUR_USERNAME pptpd $YOUR_PASSWORD *" >> /etc/ppp/chap-secrets 
echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options
echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options
service pptpd restart

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save
