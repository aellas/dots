  { pkgs, ... }:
{
    programs.bolt-launcher = {
        enable = true;
    };
  
  nixpkgs.overlays = [
  (self: super: {
    bolt-launcher = super.bolt-launcher.override {
      enableRS3 = true;
      };
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
   "openssl-1.1.1w"
  ];
}