{
  description = "Nixos config flake";

  inputs = {
  
  nixpkgs = {
    url = "github:NixOS/nixpkgs/nixos-unstable";
  };
	
	nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
	};
    
	home-manager = {
	  url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
	};

  rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
  };
  
  nixcord = {
    url = "github:kaylorben/nixcord";
  };
};

  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, ... }:
    let
      system = "x86_64-linux";

      mkNixosConfig = { name, hardwareModule, extraModules ? [] }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; host = name; };

          modules = [

            ./hosts/${name}/default.nix
            ./modules/programs/default.nix
            ./modules/core/default.nix
            ./modules/services/default.nix
            ./modules/system/default.nix

            hardwareModule

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.array = import ./home/home.nix;
              home-manager.sharedModules = [
                inputs.nixcord.homeModules.nixcord
              ];
            }
          ] ++ extraModules;
        };

    in
    {
      nixosConfigurations = {
        "thinknix" = mkNixosConfig {
          name = "thinknix";
          hardwareModule = nixos-hardware.nixosModules.lenovo-thinkpad-x390;
          extraModules = [
            ./modules/services/thinkfan.nix
           # ./modules/services/thinktlp.nix
            ./modules/services/thinkundervolt.nix
            ];
        };

        "xpsnix" = mkNixosConfig {
          name = "xpsnix";
          hardwareModule = nixos-hardware.nixosModules.dell-xps-13-7390;
        };

        "arynix" = mkNixosConfig {
          name = "arynix";
          hardwareModule = {};
          extraModules = [
            ./modules/drivers/amd.nix
            ./modules/programs/corectrl.nix
        ];
      };
    };
  };
}
