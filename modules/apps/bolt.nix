{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (bolt-launcher.override { enableRS3 = true; })
  ];
}
