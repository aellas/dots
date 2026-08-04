{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts
    font-awesome
    material-icons
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    maple-mono.NormalNL-NF
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    material-design-icons
    nerd-fonts.hack
  ];
}