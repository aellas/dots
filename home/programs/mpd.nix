# Your mpd.nix file
{ config, pkgs, lib, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/array/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

}