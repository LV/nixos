# NixOS
_My personal NixOS configuration_

## Getting started
1. Download the [minimal ISO image](https://nixos.org/download/#nixos-iso)
2. Follow the NixOS [instructions for a manual installation](https://nixos.org/manual/nixos/stable/#sec-installation-manual)
[TODO]: Verify that these following steps are correct; I'm suspecting we need to install Nix flakes first
3. Clone this repository
4. Run `sudo nixos-rebuild switch --flake CWD/#default` where `CWD` is the full filepath of the repository
