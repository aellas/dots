{pkgs, ...}:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock; # or swaylock-effects if you want the effects fork
    settings = {
      color = "27272E";     # background color
      inside-color = "3C3C46";
      ring-color = "9DA2FF";
      text-color = "D3DAE3";
      key-hl-color = "9F7AEA";
      line-color = "00000000";
      separator-color = "00000000";
      show-failed-attempts = true;
      indicator-idle-visible = true;
      grace = 2;
      fade-in = 0.2;
    };
  };
}
