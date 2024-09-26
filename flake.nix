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
    nixosConfigurations.lunix = nixpkgs.lib.nixosSystem {
      system = if builtins.getEnv "NIX_SYSTEM" == "aarch64" then "aarch64-linux"
               else "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./common/configuration.nix
      ];
    };
  };
}
