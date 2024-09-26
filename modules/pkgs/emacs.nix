{ pkgs, config, inputs, ... }:

let
  secrets = import ../../secrets.nix;
  configDir = "${config.home.homeDirectory}/.config/emacs";

  emacsWithDeps = pkgs.emacs.overrideAttrs (oldAttrs: rec {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
      pkgs.sqlite
      pkgs.libvterm
      pkgs.libtool
      pkgs.pkg-config
      pkgs.gcc
      pkgs.autoconf
      pkgs.automake
      pkgs.gnumake
    ];
  });
in
{
  # Use customized Emacs package via programs.emacs.package
  programs.emacs = {
    enable = true;
    package = emacsWithDeps;
  };

  # Include other necessary packages
  home.packages = with pkgs; [
    nil     # Nix LSP
    pyright # Python LSP
    ripgrep
    texliveFull
  ];

  # Set environment variables to help Emacs find headers
  home.sessionVariables = {
    # Add the include path for sqlite
    CPATH = "${pkgs.sqlite}/include";

    # Add the library path for sqlite
    LIBRARY_PATH = "${pkgs.sqlite}/lib";
  };
  
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
