{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (flameshot.override { enableWlrSupport = true; })
  ];
}

# TODO: Fix broken clipboard
