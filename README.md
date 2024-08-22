# NixOS
_My personal NixOS configuration_

## Getting started
1. Download the [minimal ISO image](https://nixos.org/download/#nixos-iso)
2. Follow the NixOS [instructions for a manual installation](https://nixos.org/manual/nixos/stable/#sec-installation-manual)
3. Add `git` to your `/etc/nixos/configuration.nix` file. You can do this by adding the following:
```nix
environment.systemPackages = with pkgs; [
  # ...
  git
];

programs.git = {
  enable = true;
  config.user = {
    name = "Your Name";
    email = "Your Email";
  };
};
```
4. Rename your `/etc/nixos` directory, and then clone this repository
5. Move any existing config files such as `hardware-configuration.nix` from the old directory to the cloned repo; delete the old directory.
