{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      material-icons
      fira-code
      fira-code-symbols
      nerd-fonts.ubuntu
      nerd-fonts.jetbrains-mono
      maple-mono.NormalNL-NF
      nerd-fonts.hack
    ];
  };
}