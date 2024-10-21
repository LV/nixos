# age: Actual Good Encryption
# GPG alternative

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age
  ];
}
