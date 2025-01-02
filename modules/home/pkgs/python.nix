{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python312
    python313Full
  ];
}
