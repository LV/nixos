# LV's NixOS Configuration Flake

## Getting started
1. Download the [minimal ISO image](https://nixos.org/download/#nixos-iso)
2. Follow the NixOS [instructions for a manual installation](https://nixos.org/manual/nixos/stable/#sec-installation-manual)
3. Clone this repository
4. Run
   ```sh
     sudo nixos-rebuild switch --flake CWD/#default
   ```
   where `CWD` is the full filepath of the repository (or just run `make`)

## Troubleshooting
### My architecture is not supported!
Run `sudo nixos-generate-config` and then copy over the `/etc/nixos/hardware-configuration.nix` file to `hosts/` in the repo

**TODO**: Fix the configuration if statements for architecture. Currently will only check if system is `aarch64`, and will mark architecture as `x86` if that's not the case. In new architectures such as RISC-V, this will totally fail.

### File not found after editing config and running ~make~
You will need to do a `git add .` before running `make`
