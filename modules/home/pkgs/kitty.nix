{ ... }:

{
  programs.kitty = {
    enable = true;

    # See: https://wiki.nixos.org/wiki/Kitty#Configuration
    settings = {
      background_blur = 5;
      background_opacity = "0.65";
      confirm_os_window_close = 0;
      font_family = "PragmataPro Mono Liga";
      font_size = "19";
    };
  };
}
