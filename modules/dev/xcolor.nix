{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "xcolor-dev";

  nativeBuildInputs = with pkgs; [
    pkg-config
    rustc
    cargo
  ];

  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libxcb
    xorg.libXau
    xorg.libXdmcp
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${
      pkgs.lib.makeLibraryPath [
        pkgs.xorg.libX11
        pkgs.xorg.libXcursor
        pkgs.xorg.libxcb
        pkgs.xorg.libXau
        pkgs.xorg.libXdmcp
      ]
    }"
  '';
}
