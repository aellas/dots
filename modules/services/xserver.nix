{ config, pkgs, ... }:
let
  isxps = config.networking.hostName == "xpsnix";
  isthink= config.networking.hostName == "thinknix";
  isGBLayout = isxps || isthink; 
in
{
  services.xserver = {
    enable = true;
    xkb = {
      layout = if isGBLayout then "gb" else "us";
      variant = "";
    };
  };
}
