{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox-devedition # has more dev tools and default dark mode than regular Firefox
  ];

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # Force Firefox to use Wayland
  };
}
