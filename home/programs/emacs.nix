{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
  };

  home.packages = with pkgs; [
    git            # Doom needs this to install
    ripgrep        # search support (used in Doom)
    fd             # better `find` (used in Doom)
    gnupg          # to verify packages
    unzip          # required by some packages
    gnutls         # SSL support in Emacs
    nodejs         # for JS/TS LSPs
    python3        # for Python LSPs and tools
    lua-language-server
    texlive.combined.scheme-small # for AUCTeX if needed
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "emacsclient";
  };

}
