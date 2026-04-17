{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
  ];

  # Claude Code defaults: use Anthropic-compatible gateway URL.
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
