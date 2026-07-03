{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ];
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
    (pkgs.writeShellScriptBin "orgnote-cli" ''
      exec ${pkgs.nodejs}/bin/npx orgnote-cli@dev "$@"
    '')
    pkgs.google-fonts
    pkgs.vips
  ];
}
