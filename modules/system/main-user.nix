{ lib, config, ... }:

let
  cfg = config.main-user;
in
{
  options = {
    main-user.enable = lib.mkEnableOption "enable user module";

    main-user.userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };

    main-user.hashedPasswordFile = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = ''
        Path to a file containing the hashed password for the main user.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = "main user";
      extraGroups = [
        "audio"  # give permissions to modify audio (pipeware and alsa)
        "docker" # docker: Get access to the socket
        "wheel"  # wheel: enable `sudo` for the user
      ];
      hashedPasswordFile = cfg.hashedPasswordFile;
    };
  };
}
