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
            "apiKey": "{env:WATARUU_API_KEY}"
          },
          "models": {
            "gpt-5.4": {
              "name": "GPT-5.4"
            }
          }
        }
      },
      "model": "wataruu/gpt-5.4",
      "small_model": "wataruu/gpt-5.4"
    }
  '';
}
