{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    ktailctl
    trayscale
    tail-tray
  ];
}
