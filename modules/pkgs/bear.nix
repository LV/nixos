# Generate compilation database for clang tooling

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bear
  ];
}
