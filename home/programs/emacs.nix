{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
  };

  home.packages = with pkgs; [
    git          
    ripgrep        
    fd             
    gnupg          
    unzip          
    gnutls         
    nodejs         
    python3        
    lua-language-server
    texlive.combined.scheme-small 
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "emacsclient";
  };

}
