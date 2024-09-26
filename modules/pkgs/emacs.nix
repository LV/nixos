{ pkgs, config, inputs, ... }:

let
  secrets = import ../../secrets.nix;
  configDir = "${config.home.homeDirectory}/.config/emacs";
in
{
  # Add emacs (and dependencies) to main user packages
  home.packages = with pkgs; [
    emacs

    # dependencies
    cmake
    ripgrep


    ## Latex
    texliveFull

    ## VTerm
    libtool
    libvterm


    ## LSPs
    ### Nix
    nil

    ### Python
    pyright
  ];

  # Home Manager configuration for Emacs and dotfiles
  home.activation = {
    cloneDotfiles = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Remove .emacs.d if it exists
      if [ -d ${config.home.homeDirectory}/.emacs.d ]; then
        rm -rf ${config.home.homeDirectory}/.emacs.d
      fi

      # Clone the Emacs config if it doesn't already exist
      if [ ! -d ${configDir} ]; then
        ${pkgs.git}/bin/git clone https://${secrets.githubUsername}:${secrets.githubToken}@github.com/lv/emacs.git ${configDir}
      fi
    '';
  };
}
