{
  pkgs,
  ...
}:

{
  # http://127.0.0.1:19798/
  home.packages = with pkgs; [ clouddrive2 ];
}
