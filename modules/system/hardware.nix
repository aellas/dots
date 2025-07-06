{ pkgs, ... }:
{
  hardware = {
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
      bluetooth = {
        enable = true;
        input.General.ClassicBondedOnly = false;
        package = pkgs.bluez;
    };
    logitech.wireless.enable = false;
    logitech.wireless.enableGraphical = false;
    graphics.enable = true;
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    bluetooth.powerOnBoot = true;
  };
}
