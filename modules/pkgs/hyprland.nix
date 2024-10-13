{ config, inputs, pkgs, ... }:

let
  secrets = import ../../secrets.nix;
  hyprlandConfigDir = "${config.home.homeDirectory}/.config/hypr";
in
{
  # Include necessary dependencies for Hyprland config
  home.packages = with pkgs; [
    waybar
    wofi
  ];

  # Home Manager configuration for getting Hyprland dotfiles
  home.activation = {
    cloneHyprlandDotfiles = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Clone the Hyprland config if it doesn't already exist
      if [ ! -d ${hyprlandConfigDir} ]; then
        ${pkgs.git}/bin/git clone https://${secrets.githubUsername}:${secrets.githubToken}@github.com/lv/hypr-config.git ${hyprlandConfigDir}
      fi
    '';
  };
}
