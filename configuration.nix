{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix> ];

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  programs.git = {
    enable = true;
    config.user = {
      name = "Luis Victoria";
      email = "v@lambda.lv";
    };
  };
}
