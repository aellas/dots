{
  config,
  lib,
  pkgs,
  ...
}:

{
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

}
