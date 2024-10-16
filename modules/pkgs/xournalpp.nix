# Note-taking application designed for handwritten notes, PDF annotations, and sketching
#   supports stylus input

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xournalpp
  ];
}
