apt-get update
apt-get install -y wireguard
cd /etc/wireguard
touch wg0.conf
nano wg0.conf

systemctl enable wg-quick@wg0
wg-quick up wg0
ping 10.252.1.1

h9x4B0CuFR7wmcWg8oxnD4rXx2TKjpDI9T8PYJng
