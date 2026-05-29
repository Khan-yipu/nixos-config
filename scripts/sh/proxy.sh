sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
sudo tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="http_proxy=socks5h://localhost:7897"
Environment="https_proxy=socks5h://localhost:7897"
Environment="HTTP_PROXY=socks5h://localhost:7897"
Environment="HTTPS_PROXY=socks5h://localhost:7897"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
