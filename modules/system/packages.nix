{ pkgs, inputs, ...}: {
  
   nixpkgs.config.allowUnfree = true;

   environment.systemPackages = with pkgs; [   
       sshfs-fuse 
       libgcc
       protonvpn-gui
       remmina
       github-desktop
       youtube-music
       protonvpn-gui
       wiremix
       gtk-frdp
       parsec-bin
   ];

   nixpkgs.config.permittedInsecurePackages = [
     "openssl-1.1.1w"
    ];
}
