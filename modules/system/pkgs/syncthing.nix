# Documentation: https://wiki.nixos.org/wiki/Syncthing
{ ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui = {
      user = "myuser";
      password = "mypassword";
    };
  };
}
