{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    skippy-xd
  ];

}
