{ pkgs, inputs, ...}: {
  
   nixpkgs.config.allowUnfree = true;

   environment.systemPackages = with pkgs; [   
       sshfs-fuse 
       libgcc
       heroic
       protonvpn-gui
       virt-viewer
       virt-manager
       remmina
       yaru-theme
   ];

   nixpkgs.config.permittedInsecurePackages = [
     "openssl-1.1.1w"
    ];
}
