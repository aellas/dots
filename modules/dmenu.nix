{ pkgs, ... }:

let
  dmenu-centered = pkgs.dmenu.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (pkgs.fetchpatch {
        url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-alpha-20210715-4e95c15.diff";
        sha256 = pkgs.lib.fakeSha256; # placeholder, see step 3
      })
    ];
  });
in
{
  home.packages = [ dmenu-centered ];
}
