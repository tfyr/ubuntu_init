sudo tee /etc/systemd/system/udp-forward.service << EOF
[Unit]
Description=UDP Port Forward 1111
After=network.target

[Service]
ExecStart=/usr/bin/socat UDP4-LISTEN:1111,fork,reuseaddr UDP4:$1:1111
Restart=always
User=nobody

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable --now udp-forward.service
