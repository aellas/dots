{pkgs, ...}:
{
  programs.floorp = {
    enable = true;
    package = pkgs.floorp;
  };
}
