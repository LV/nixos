{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/lv/nix-secrets";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, sops-nix, ... }@inputs: {
    nixosConfigurations.lunix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./common/configuration.nix
        sops-nix.nixosModules.sops
      ];
    };

    homeManagerConfigurations = {
      lv = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        homeDirectory = "/home/lv";
        username = "lv";
        configuration = import ./common/home.nix {
          inherit inputs;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    };
  };
}
