{ config, inputs, pkgs, ... }:

let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/88195a94f390381c6afcdaa933c2f6ff93959cb4.tar.gz";
    sha256 = "1fs25csg0lq3v34jdzxr2qdvnyvylimmfh0qxlf39h4j1hclvbyj";
  }) {
    system = "x86_64-linux";
  };
  ghosttyConfigDir = "${config.home.homeDirectory}/.config/ghostty";
in {
  home.packages = [
    unstable.ghostty
  ];

  home.activation = {
    cloneDotfilesGhostty = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Clone the Ghostty config if it doesn't already exist
      if [ ! -d ${ghosttyConfigDir} ]; then
        # First try cloning with SSH
        if ! GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh" ${pkgs.git}/bin/git clone git@github.com:lv/ghostty-config.git ${ghosttyConfigDir} 2>/dev/null; then
          # Try HTTPS if SSH fails
          if ! ${pkgs.git}/bin/git clone https://github.com/lv/ghostty-config.git ${ghosttyConfigDir}; then
            echo "Failed to clone Ghostty config repository using both SSH and HTTPS"
            exit 1
          fi
        fi
      fi
    '';
  };
}
