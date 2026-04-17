{ config, pkgs, lib, ... }:

{
  # Install AI CLIs directly from nixpkgs (no manual npm -g needed).
  home.packages = with pkgs; [
    codex
  ];

  # Codex configuration
  home.file.".codex/config.toml".text = ''
    model_provider = "chatanywhere"
    model = "gpt-5.3-codex-ca"
    model_reasoning_effort = "high"
    disable_response_storage = true
    preferred_auth_method = "apikey"

    [model_providers.chatanywhere]
    name = "chatanywhere"
    base_url = "https://api.chatanywhere.tech/v1"
    wire_api = "responses"
    env_key = "CHATANYWHERE_API_KEY"
  '';

  # Configure npm to use local prefix
  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm-global
    registry=https://registry.npmmirror.com
  '';

  # Add npm global bin to PATH
  programs.fish.loginShellInit = lib.mkAfter ''
    if test -d "${config.home.homeDirectory}/.npm-global/bin"
      fish_add_path --append "${config.home.homeDirectory}/.npm-global/bin"
    end
  '';
}
