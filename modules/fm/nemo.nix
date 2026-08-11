{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nemo
    nemo-fileroller
    nemo-preview
    nemo-emblems
    nemo-seahorse
  ];

}
