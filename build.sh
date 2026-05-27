   sudo nixos-rebuild switch --flake .#khanixos \
     --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store https://cache.nixos.org" 
	 # --install-bootloader
