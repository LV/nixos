{ pkgs, ... }:

{
  # Install swaylock and Hyprland
  environment.systemPackages = with pkgs; [
    hyprland
  ];

  programs.hyprland = {
    enable = true;
  };
}
