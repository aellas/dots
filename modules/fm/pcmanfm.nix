{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    pcmanfm
    nemo-fileroller
  ];

}
