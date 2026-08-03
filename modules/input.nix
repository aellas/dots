{
  config,
  pkgs,
}:
{
  programs.talib.enable = true;
  programs.talib.input.enable = true;
  programs.talib.input.mouse.enable = true;
}
