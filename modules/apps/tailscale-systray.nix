{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    tailscale-systray
  ];

}
