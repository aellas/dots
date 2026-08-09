{
  description = "My Fedora Home Manager config";
  inputs = {

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    st = {
      url = "github:siduck/st";
    };

  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      helium,
      st,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          problems.handlers = {
            bolt-launcher.broken = "warn";
          };
        };
      };
    in
    {
      homeConfigurations.array = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home.nix
        ];
      };
    };
}
