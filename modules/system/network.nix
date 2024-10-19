{ ... }:

let
  secrets = import ../../secrets.nix;
in
{
  networking.networkmanager.enable = true; # nmtui
}
