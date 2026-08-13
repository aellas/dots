{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    bambu-studio
  ];

}
