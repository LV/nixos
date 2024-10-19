{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (flameshot.override { enableWlrSupport = true; })
  ];
}
