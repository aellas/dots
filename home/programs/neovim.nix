{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    pyright
    lua-language-server
  ];

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
