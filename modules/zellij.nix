{ ... }:

{
  programs.zellij = {
    enable = true;

    # Shell 集成
    enableFishIntegration = false;

    # 如果已存在会话则自动附加
    attachExistingSession = false;
  };
}

