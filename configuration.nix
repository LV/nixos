{ config, pkgs, lib, ... }:

let
  secrets = import ./secrets.nix;
  hostname = "lambdapi";
  user = "lv";
  password = secrets.password;
  nixosHardwareVersion = "7f1836531b126cfcf584e7d7d71bf8758bb58969";

  timeZone = "America/New_York";
  defaultLocale = "en_US.UTF-8";

  modulesDir = "/etc/nixos/modules";
  # moduleFiles = builtins.attrNames (builtins.readDir modulesDir);
  moduleFiles = builtins.filter (file: builtins.match ".+\\.nix$" file != null) (builtins.attrNames (builtins.readDir modulesDir));
  moduleImports = builtins.map (file: import (modulesDir + "/" + file)) moduleFiles;
in {
  imports = [
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/${nixosHardwareVersion}.tar.gz" }/raspberry-pi/4"
    <home-manager/nixos>
  ] ++ moduleImports;

  environment.systemPackages = with pkgs; [
    firefox
    git
    vim
  ];

  # Home Manager config
  home-manager.users.lv = {
    home.username = "lv";
    home.homeDirectory = "/home/lv";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
    programs.git = {
      enable = true;
      userName = "Luis Victoria";
      userEmail = "v@lambda.lv";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking.hostName = hostname;

  services.openssh.enable = true;

  time.timeZone = timeZone;

  i18n = {
    defaultLocale = defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_NAME = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_TIME = defaultLocale;
    };
  };

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      password = password;
      extraGroups = [ "wheel" ];
    };
  };

  # Enable passwordless sudo.
  security.sudo.extraRules= [
    {  users = [ user ];
      commands = [
         { command = "ALL" ;
           options= [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  hardware.pulseaudio.enable = true;

  system.stateVersion = "23.11";
}
