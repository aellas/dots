{pkgs, ...}: {
  home.packages = with pkgs; [
 ];

  home.file = {
    ".config/qtile" = {
      source = ./qtile;
      recursive = true;
    };
  };
}
