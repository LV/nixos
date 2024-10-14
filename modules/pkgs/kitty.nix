{ config, inputs, pkgs, ... }:

let
  secrets = import ../../secrets.nix;
  kittyConfigDir = "${config.home.homeDirectory}/.config/kitty";
in
{
  programs.kitty = {
    enable = true;
  };

  # Home Manager configuration for getting Kitty dotfiles
  home.activation = {
    cloneKittyDotfiles = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Clone the Hyprland config if it doesn't already exist
      if [ ! -d ${kittyConfigDir} ]; then
        ${pkgs.git}/bin/git clone https://${secrets.githubUsername}:${secrets.githubToken}@github.com/lv/kitty-config.git ${kittyConfigDir}
      fi
    '';
  };
}
