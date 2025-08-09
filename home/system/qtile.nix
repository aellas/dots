{pkgs, ...}: {
  home.packages = with pkgs; [
 ];

 imports = [
  ./qtile/config.nix
  ./qtile/functions.nix

 ];
}
