{ config, inputs, pkgs, ... }:

let
  secrets = import ../../../secrets.nix;
  nvimConfigDir = "${config.home.homeDirectory}/.config/nvim";
in
{
  programs.neovim = {
    enable = true;
  };

  # Include necessary packages
  home.packages = with pkgs; [
    clang-tools
    efm-langserver
    fzf
    lazygit
    lua-language-server
    luajitPackages.luacheck
    nixd
    ripgrep
    tinymist
    wl-clipboard
  ];

  # Home Manager configuration for getting Neovim dotfiles
  home.activation = {
    cloneDotfilesNeovim = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Clone the Neovim config if it doesn't already exist
      if [ ! -d ${nvimConfigDir} ]; then
        ${pkgs.git}/bin/git clone https://${secrets.githubUsername}:${secrets.githubToken}@github.com/lv/nvim-config.git ${nvimConfigDir}
      fi
    '';
  };
}
