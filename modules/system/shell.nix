{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      gnumake
      tmux
      vim
      wget
    ];

    variables = {
      EDITOR = "vim";
    };
  };

  programs.zsh.enable = true;
}
