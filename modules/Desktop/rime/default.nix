{
  ...
}:

{
  xdg.dataFile = {
    "fcitx5/rime/default.custom.yaml".source = ./dotfiles/default.custom.yaml;
  };

  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
  };
}
