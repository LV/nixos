{ pkgs, ... }:

{
  home.packages = with pkgs; [
    elixir

    # Dependencies
    inotify-tools
  ];
}
