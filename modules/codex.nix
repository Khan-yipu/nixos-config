{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    WATARUU_API_KEY = "sk-BOIfaNR9CVuERB57c";
  };

  # Codex configuration
  home.file.".codex/config.toml".text = ''
    model_provider = "zeabur"
    model = "gpt-5.3-codex"
    model_reasoning_effort = "high"
    disable_response_storage = true
    preferred_auth_method = "apikey"

    [model_providers.chatanywhere]
    name = "chatanywhere"
    base_url = "https://api.chatanywhere.tech/v1"
    wire_api = "responses"

    [model_providers.zeabur]
    name = "zeabur"
    base_url = "https://mycli6.zeabur.app/v1"
    wire_api = "responses"
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
