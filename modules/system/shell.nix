{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      gnumake
      vim
      wget
    ];

    variables = {
      EDITOR = "vim";
    };
  };

  programs.zsh.enable = true;
}
