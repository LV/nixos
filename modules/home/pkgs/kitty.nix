{ ... }:

{
  programs.kitty = {
    enable = true;

    # See: https://wiki.nixos.org/wiki/Kitty#Configuration
    settings = {
      background_blur = 5;
      background_opacity = "0.65";
    };
  };
}
