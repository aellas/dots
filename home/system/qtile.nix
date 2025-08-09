{pkgs, ...}: {
  home.packages = with pkgs; [
 ];

 imports = [
  ./qtile/config.nix
  ./qtile/functions.nix
  ./qtile/scripts/wayland.nix
  ./qtile/scripts/screenshot.nix
  ./qtile/scripts/nix.nix

 ];
}
