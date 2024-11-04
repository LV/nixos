{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Pre-requisites
    python312
    python312Packages.manim
  ];
}
