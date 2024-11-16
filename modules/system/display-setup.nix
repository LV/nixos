{ pkgs, ... }:

let

  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "0m9grvfsbwmvgwaxvdzv6cmyvjnlww004gfxjvcl806ndqaxzy4j";
  };
  hyprland = (import flake-compat {
    src = builtins.fetchTarball {
      url = "https://github.com/hyprwm/Hyprland/archive/main.tar.gz";
      sha256 = "1dl6mm0pj4zfbzk3yxmw6yd16brfnd9n16clrlhyjcjq1sdw28sv";
    };
  }).defaultNix;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  # Install swaylock and Hyprland
  environment.systemPackages = [
    hyprland
  ];

  programs.hyprland = {
    enable = true;

    # Set the flake package
    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # make sure to also set the portal package, so that they are in sync
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
