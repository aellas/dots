{ pkgs, ... }:

{

  programs.virt-manager = {
    enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  services.qemuGuest = {
    enable = true;
    };

  services.spice-vdagentd = {
    enable = true;
  };
  
}
