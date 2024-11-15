{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      diff = "delta";
      gg = "lazygit";
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
}
