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
        "wataruu": {
          "npm": "@ai-sdk/openai-compatible",
          "name": "Wataruu",
          "options": {
            "baseURL": "https://api.wataruu.me/v1",
          },
          "models": {
            "gpt-5.4": {
              "name": "GPT-5.4"
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
