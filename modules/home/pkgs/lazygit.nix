{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
  ];

  home.activation = {
    addAliasLazygit = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      # Add alias 'gg' to run Lazygit
      if ! grep -q "alias gg='lazygit'" ~/.bashrc; then
        echo "alias gg='lazygit'" >> ~/.bashrc
      fi

      if ! grep -q "alias gg='lazygit'" ~/.zshrc; then
        echo "alias gg='lazygit'" >> ~/.zshrc
      fi
    '';
  };
}
