{ config, inputs, pkgs, ... }:

let
  secrets = import ../../secrets.nix;
  nvimConfigDir = "${config.home.homeDirectory}/.config/nvim";
in
{
  # Use customized Emacs package via programs.emacs.package
  programs.neovim = {
    enable = true;
  };

  # Home Manager configuration for getting Neovim dotfiles
  home.activation = {
    cloneNeovimDotfiles = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Clone the Neovim config if it doesn't already exist
      if [ ! -d ${nvimConfigDir} ]; then
        ${pkgs.git}/bin/git clone https://${secrets.githubUsername}:${secrets.githubToken}@github.com/lv/nvim-config.git ${nvimConfigDir}
      fi

      # Add alias for 'v' to run Neovim
      if ! grep -q "alias v='nvim'" ~/.bashrc; then
        echo "alias v='nvim'" >> ~/.bashrc
      fi
      if ! grep -q "alias v='nvim'" ~/.zshrc; then
        echo "alias v='nvim'" >> ~/.zshrc
      fi
    '';
  };
}
