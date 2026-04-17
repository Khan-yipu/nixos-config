{ config, pkgs, lib, ... }:

{
  # Install AI CLIs directly from nixpkgs (no manual npm -g needed).
  home.packages = with pkgs; [
    codex
    claude-code
  ];

  # Claude Code defaults: use Anthropic-compatible gateway URL.
  # API key is loaded from a local file outside this repo.
  home.file.".claude/settings.json".text = ''
    {
      "$schema": "https://json.schemastore.org/claude-code-settings.json",
      "model": "claude-sonnet-4-6",
      "env": {
        "ANTHROPIC_BASE_URL": "https://code.newcli.com/claude/super",
        "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
        "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
        "CLAUDE_CODE_DISABLE_TERMINAL_TITLE": "1"
      }
    }
  '';

  # Keep secret material out of Git-tracked Nix files.
  home.file.".config/ai-secrets/README.md".text = ''
    # AI Secrets (local only)

    Put your Anthropic API key in:

    ~/.config/ai-secrets/anthropic_api_key

    Put your ChatAnywhere API key in:

    ~/.config/ai-secrets/chatanywhere_api_key

    Suggested permissions:

    chmod 700 ~/.config/ai-secrets
    chmod 600 ~/.config/ai-secrets/anthropic_api_key
    chmod 600 ~/.config/ai-secrets/chatanywhere_api_key
  '';

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
    if test -f "${config.home.homeDirectory}/.config/ai-secrets/anthropic_api_key"
      set -gx ANTHROPIC_AUTH_TOKEN (cat "${config.home.homeDirectory}/.config/ai-secrets/anthropic_api_key")
    end

    if test -d "${config.home.homeDirectory}/.npm-global/bin"
      fish_add_path --append "${config.home.homeDirectory}/.npm-global/bin"
    end

    if test -f "${config.home.homeDirectory}/.config/ai-secrets/chatanywhere_api_key"
      set -gx CHATANYWHERE_API_KEY (cat "${config.home.homeDirectory}/.config/ai-secrets/chatanywhere_api_key")
    end
  '';

  # Quick Claude Code ChatAnywhere helper.
  programs.fish.functions = {
    claude-ca = ''
      set -l chatanywhere_key (cat ~/.config/ai-secrets/chatanywhere_api_key 2>/dev/null | string trim)
      if test -z "$chatanywhere_key"
        echo "Missing key: ~/.config/ai-secrets/chatanywhere_api_key"
        return 1
      end

      env \
        ANTHROPIC_BASE_URL="https://api.chatanywhere.tech" \
        ANTHROPIC_AUTH_TOKEN="$chatanywhere_key" \
        claude $argv
    '';
  };
}
