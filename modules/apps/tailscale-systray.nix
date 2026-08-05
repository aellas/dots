{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    tailscale-systray
    tail-tray
    ktailctl
  ];

}
