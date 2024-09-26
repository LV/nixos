{ pkgs, config, lib, ... }:

{
  # Add emacs (and dependencies) to main user packages
  environment.systemPackages = with pkgs; [
    emacs
    ripgrep
  ];
}
