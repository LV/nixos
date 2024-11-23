{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    gcc # necessary for the linker
    rust-analyzer
    rustc
  ];
}
