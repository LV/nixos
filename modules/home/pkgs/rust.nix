{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    cargo-make
    gcc # necessary for the linker
    rust-analyzer
    rustc
  ];
}
