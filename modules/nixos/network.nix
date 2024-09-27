{ config, pkgs, ... }:

let
  secrets = import ../../secrets.nix;
in
{
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "${secrets.wifiNetwork.ssid}" = {
      psk = secrets.wifiNetwork.passkey;
    };
  };

  # FALLBACK; uncomment if the above breaks; use `sudo nmtui`
  # networking.networkmanager.enable = true;
}
