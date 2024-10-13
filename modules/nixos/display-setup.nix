{ pkgs, ... }:

{
  # Install swaylock and Hyprland
  environment.systemPackages = with pkgs; [
    swaylock
    hyprland
    waybar
  ];

  # Define systemd service for the lock screen (swaylock)
  systemd.user.services.swaylock = {
    description = "Swaylock Lock Screen";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swaylock}/bin/swaylock -c 000000"; # `-c` refers to color and 000000 is the color hex
    };
  };

  # Define systemd service for Hyprland
  systemd.user.services.hyprland = {
    description = "Hyprland Session";
    wantedBy = [ "graphical-session.target" ];
    after = [ "swaylock.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.hyprland}/bin/Hyprland";
    };
  };

  # Define systemd service for Waybar
  systemd.user.services.waybar = {
    description = "Waybar Status Bar";
    wantedBy = [ "graphical-session.target" ];
    after = [ "hyprland.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
    };
  };
}
