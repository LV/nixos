{ config, inputs, pkgs, ... }:

let
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
    vimPlugins.firenvim
    wl-clipboard
  ];

  # Home Manager configuration for getting Neovim dotfiles
  home.activation = {
    cloneDotfilesNeovim = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Clone the Neovim config if it doesn't already exist
      if [ ! -d ${nvimConfigDir} ]; then
        ${pkgs.git}/bin/git clone git@github.com:lv/nvim-config.git ${nvimConfigDir}
      fi
    '';
  };
}
