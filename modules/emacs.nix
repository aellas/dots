{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
  home.packages = [
    pkgs.git
    pkgs.ripgrep
    pkgs.libtool
    pkgs.cmake
    pkgs.pkg-config
    pkgs.clang-tools
    pkgs.hunspell
    pkgs.hunspellDicts.en_AU
    pkgs.hunspellDicts.es_ES
    pkgs.hunspellDicts.en-gb-ise
    pkgs.gcc
    pkgs.gnumake
    pkgs.mpv
    pkgs.nodejs_24
    pkgs.nixfmt
    pkgs.prettier
    pkgs.fd
    pkgs.ripgrep
    pkgs.findutils
    pkgs.mlocate
    pkgs.lua
    pkgs.stylua
    pkgs.shfmt
    pkgs.shellcheck
    pkgs.black
    pkgs.lua-language-server
    pkgs.nixd
    pkgs.python3
    pkgs.python3Packages.python-lsp-server
    pkgs.python3Packages.grip
    pkgs.rustup
    pkgs.jetbrains.rust-rover
    pkgs.tree-sitter-grammars.tree-sitter-toml
    (pkgs.writeShellScriptBin "orgnote-cli" ''
      exec ${pkgs.nodejs}/bin/npx orgnote-cli@dev "$@"
    '')
    pkgs.google-fonts
    pkgs.nixd
  ];

}
