# Currently not being used

{ config, inputs, pkgs, ... }:

let
  emacsConfigDir = "${config.home.homeDirectory}/.config/emacs";

  emacsWithCustomOptions = pkgs.emacs.overrideAttrs (oldAttrs: {
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

    # TODO: Investigate which of these are useless (I suspect many of them are)
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
    cmake
    emacsPackages.mermaid-mode
    emacsPackages.ob-mermaid
    emacsPackages.sqlite3
    git
    gnutls
    libtool
    mermaid-cli
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
    cloneEmacsDotfiles = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Remove .emacs.d if it exists
      if [ -d ${config.home.homeDirectory}/.emacs.d ]; then
        rm -rf ${config.home.homeDirectory}/.emacs.d
      fi

      # Clone the Emacs config if it doesn't already exist
      if [ ! -d ${emacsConfigDir} ]; then
        # First try using SSH with explicit SSH command
        if ! GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh" ${pkgs.git}/bin/git clone git@github.com:lv/emacs.git ${emacsConfigDir} 2>/dev/null; then
          # If SSH fails, try HTTPS
          if ! ${pkgs.git}/bin/git clone https://github.com/lv/emacs.git ${emacsConfigDir}; then
            echo "Failed to clone Emacs config repository using both SSH and HTTPS"
            exit 1
          fi
        fi
      fi

      # Create the org/roam directory if it doesn't exist
      if [ ! -d ${config.home.homeDirectory}/org/roam ]; then
        mkdir -p ${config.home.homeDirectory}/org/roam
      fi
    '';
  };
}
