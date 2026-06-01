# Personal Nix Configuration Justfile

default:
	@just --list

# =========================================================
# Home Manager (Arch WSL 等用户级配置)
# =========================================================

# 应用 Home Manager 配置
hm-switch:
	home-manager switch --flake .#khanixos

# 备份并应用 Home Manager 配置
hm-switch-backup:
	home-manager switch -b backup --flake .#khanixos

# 更新 Flake 锁并应用 Home Manager 配置
hm-update:
	nix flake update
	home-manager switch --flake .#khanixos

# 查看 Home Manager 的新闻/更新内容
hm-news:
	home-manager news --flake .#khanixos

# =========================================================
# NixOS (虚拟机/物理机系统级配置)
# =========================================================

# 应用 NixOS 系统配置
os-switch host="khanixos":
	sudo nixos-rebuild switch --flake .#{{host}}

# 更新 Flake 锁并应用 NixOS 系统配置
os-update host="khanixos":
	nix flake update
	sudo nixos-rebuild switch --flake .#{{host}}

# =========================================================
# 系统维护 (Maintenance)
# =========================================================

# 手动触发垃圾回收，清理超过 30 天的无用数据 (用户级)
gc:
	nix-collect-garbage --delete-older-than 30d

# 深度清理：同时清理 boot 记录（需要 root 权限，不适用于非 nixos 系统）
gc-sudo:
	sudo nix-collect-garbage -d

# 优化 /nix/store，通过硬链接去重相同的文件
optimise:
	nix-store --optimise
