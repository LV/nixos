{ config, inputs, ... }:

let
  secretspath = builtins.toString inputs.nix-secrets;
in
{
  imports =
    [
      # essential modules
      ../modules/system/audio.nix
      ../modules/system/display-setup.nix
      ../modules/system/main-user.nix
      ../modules/system/network.nix
      ../modules/system/shell.nix
      ../modules/system/ssh.nix

      # system packages
      ../modules/system/pkgs/docker.nix
      ../modules/system/pkgs/firefox.nix
      ../modules/system/pkgs/postgres.nix
      ../modules/system/pkgs/unzip.nix

      ../hosts/x86/hardware-configuration.nix
    ];

  # Enable Nix Flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    # Enable Cachix for Hyprland
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "lunix";

  time.timeZone = "America/New_York";

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      lv_passwd = {
        neededForUsers = true;
      };
    };
  };

  users.mutableUsers = false; # Force password to be what is always set in the secrets file
  main-user = {
    enable = true;
    userName = "lv";
    hashedPasswordFile = config.sops.secrets.lv_passwd.path;
  };

  # Keep this outside of Home Manager if you want `root` to have the same Git configuration
  programs.git = {
    enable = true;
    config.user = {
      name = "Luis Victoria";
      email = "v@lambda.lv";
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
