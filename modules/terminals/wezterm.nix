{
  config,
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.wezterm
    pkgs.herdr
  ];
}
