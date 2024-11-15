{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      diff = "delta";
      gg = "lazygit";
      ls = "ls --color=auto";
      v = "nvim";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    # Optionally, manage plugins using zplug
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; }
      ];
    };

    # Or using Oh-My-Zsh
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [ "git" "thefuck" ];
    #   theme = "robbyrussell";
    # };
  };

  home.file.".config/p10k.zsh".source = ../../configs/p10k.zsh;

  # Explicitly write a .zshrc file to your home directory
  home.file.".zshrc".text = ''
    # Add any additional configurations here
    export ZSH_DISABLE_COMPFIX=true
    export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
  '';
}
