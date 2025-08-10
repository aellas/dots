{pkgs, ...}: {
  home.packages = with pkgs; [
    satty
 ];

 imports = [
  ./qtile/config.nix
  ./qtile/functions.nix
  ./qtile/scripts/wayland.nix
  ./qtile/scripts/nix.nix
  ./qtile/scripts/screenshot.nix

 ];
}
