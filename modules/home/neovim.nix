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
    bash-language-server
    clang-tools
    dwt1-shell-color-scripts
    efm-langserver
    fzf
    gh
    hub
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
        # First try using SSH with explicit SSH command
        if ! GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh" ${pkgs.git}/bin/git clone git@github.com:lv/nvim-config.git ${nvimConfigDir} 2>/dev/null; then
          # If SSH fails, try HTTPS
          if ! ${pkgs.git}/bin/git clone https://github.com/lv/nvim-config.git ${nvimConfigDir}; then
            echo "Failed to clone Neovim config repository using both SSH and HTTPS"
            exit 1
          fi
        fi
      fi
    '';
  };
}
