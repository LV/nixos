{ pkgs, config, inputs, ... }:

let
  secrets = import ../../secrets.nix;
  configDir = "${config.home.homeDirectory}/.config/emacs";

  emacsWithCustomOptions = pkgs.emacs.overrideAttrs (oldAttrs: rec {
    configureFlags = (oldAttrs.configureFlags or []) ++ [
      # "--enable-profiling" # Use low-level profiling via gprof; reduces perfomance and replaces Emacs' profiler.el
      "--enable-link-time-optimization" # Compiler optimization performed on per-file basis, better performance at cost of greater build time
      "--with-cairo" # Better rendering performance
      "--with-dbus" # Enable desktop communication with Emacs (e.g. notifications and desktop integration
      "--with-file-notifications=inotify" # Use inotify for file change notifications
      "--with-gnutls" # Enable support for secure connections over SSL/TLS
      "--with-imagemagick" # Enable image support
      "--with-json" # Enable native JSON support
      "--with-mailutils" # Enable Mail
      "--with-modules" # Enable use of external modules
      "--with-native-compilation" # Native Lisp Compilation; significantly improves performance
      "--with-pdumper" # Use over `unexexc` for faster startup and dumping
      "--with-pgtk"  # GTK support for Wayland
      # "--with-sound=alsa" # Using ALSA sound system
      "--with-sqlite3" # Native sqlite3 support
      "--with-tree-sitter" # Enable syntax highlighting and parsing using tree-sitter; better performance editing code
      "--with-x" # Use XWayland as fallback for packages or features not yet ported to Wayland
      "--without-selinux" # Disable as NixOS by default does not use SELinux
    ];

    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
      pkgs.autoconf
      pkgs.automake
      pkgs.gcc
      pkgs.gnumake
      pkgs.gtk3
      pkgs.imagemagick
      pkgs.libgccjit
      pkgs.libtool
      pkgs.libvterm
      pkgs.makeWrapper
      pkgs.pkg-config
      pkgs.sqlite
    ];
  });
in
{
  # Use customized Emacs package via programs.emacs.package
  programs.emacs = {
    enable = true;
    package = emacsWithCustomOptions;
  };

  # Include other necessary packages
  home.packages = with pkgs; [
    binutils
    emacsPackages.sqlite3
    git
    gnutls
    nil     # Nix LSP
    pyright # Python LSP
    ripgrep
    sqlite
    texliveFull
  ];

  # Set environment variables to help Emacs find headers
  home.sessionVariables = {
    # Add the include and library paths for sqlite
    EMACSQL_SQLITE3_INCLUDE_DIR = "${pkgs.sqlite}/include";
    EMACSQL_SQLITE3_LIBRARY_DIR = "${pkgs.sqlite}/lib";
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
