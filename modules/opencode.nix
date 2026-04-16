{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    opencode
  ];

  # OpenCode default provider/model configuration.
  home.file.".config/opencode/opencode.jsonc".text = ''
    {
      "$schema": "https://opencode.ai/config.json",
      "provider": {
        "newcli-anthropic": {
          "npm": "@ai-sdk/anthropic",
          "name": "NewCLI Anthropic",
          "options": {
            "baseURL": "https://code.newcli.com/claude/super",
            "apiKey": "{file:~/.config/ai-secrets/anthropic_api_key}"
          },
          "models": {
            "claude-sonnet-4-6": {
              "name": "Claude Sonnet 4.6 (NewCLI)"
            }
          }
        },
        "chatanywhere": {
          "npm": "@ai-sdk/openai-compatible",
          "name": "ChatAnywhere",
          "options": {
            "baseURL": "https://api.chatanywhere.tech/v1",
          },
          "models": {
            "gpt-5.3-codex-ca": {
              "name": "GPT-5.3-Codex"
            }
          }
        }
      },
      "model": "github-copilot/gpt-5.3-codex",
      "small_model": "github-copilot/gpt-5.3-codex"
    }
  '';
}
