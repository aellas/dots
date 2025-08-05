{ config, pkgs, ... }:

let
  isxps = config.networking.hostName == "xpsnix";
  isthink = config.networking.hostName == "thinknix";
  isGBLayout = isxps || isthink;
in
{
  services.wlroots.enable = true;

  services.wlroots.extraConfig = {
    input = {
      "type:keyboard" = {
        xkb_layout = if isGBLayout then "gb" else "us";
        xkb_variant = "";
      };
    };
  };
}
