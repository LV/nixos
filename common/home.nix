{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  _module.args = {
    inherit inputs;
  };

  imports = [
    ../modules/home/hyprland.nix
    ../modules/home/zsh.nix

    # Packages
    ../modules/home/pkgs/age.nix
    ../modules/home/pkgs/bear.nix
    ../modules/home/pkgs/delta.nix
    ../modules/home/pkgs/emacs.nix
    ../modules/home/pkgs/flameshot.nix
    ../modules/home/pkgs/github.nix
    ../modules/home/pkgs/go.nix
    ../modules/home/pkgs/kitty.nix
    ../modules/home/pkgs/lazygit.nix
    ../modules/home/pkgs/manim.nix
    ../modules/home/pkgs/neovim.nix
    ../modules/home/pkgs/obsidian.nix
    ../modules/home/pkgs/python.nix
    ../modules/home/pkgs/spotify.nix
    ../modules/home/pkgs/taskwarrior.nix
    ../modules/home/pkgs/typst.nix
    ../modules/home/pkgs/xournalpp.nix
    ../modules/home/pkgs/zathura.nix
  ];

  home = {
    username = "lv";
    homeDirectory = "/home/lv";
    packages = with pkgs; [
      git
    ];
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
