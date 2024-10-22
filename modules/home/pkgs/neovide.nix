# GUI interface for Neovim

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovide
  ];
}
