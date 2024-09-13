{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        ./hosts/default/hardware-configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
