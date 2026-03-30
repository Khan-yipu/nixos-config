{ ... }:

{
  programs.zellij = {
    enable = true;

    # Shell 集成
    enableFishIntegration = true;

    # 如果已存在会话则自动附加
    attachExistingSession = true;
  };
}