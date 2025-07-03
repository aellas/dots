{ pkgs, inputs, ...}: {
  
   nixpkgs.config.allowUnfree = true;

   environment.systemPackages = with pkgs; [   
       sshfs-fuse 
   ];

   nixpkgs.config.permittedInsecurePackages = [
     "openssl-1.1.1w"
    ];
}
