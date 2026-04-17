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
        },
        "siliconflow": {
          "npm": "@ai-sdk/openai-compatible",
          "name": "SiliconFlow",
          "options": {
            "baseURL": "https://api.siliconflow.cn/v1",
            "apiKey": "{file:~/.config/ai-secrets/siliconflow_api_key}"
          },
          "models": {
            "Pro/zai-org/GLM-5.1": {
              "name": "GLM-5.1 (SiliconFlow)"
            },
            "deepseek-v3.2": {
              "name": "DeepSeek V3.2"
            }
          }
        }
      },
      "model": "siliconflow/Pro/zai-org/GLM-5.1",
      "small_model": "siliconflow/Pro/zai-org/GLM-5.1"
    }
  '';
}
