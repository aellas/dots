{
  config,
  lib,
  pkgs,
  ...
}:

{
  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "qtct";
  };

}
