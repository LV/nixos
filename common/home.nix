{ pkgs, inputs, ... }:

{
  home-manager.users.lv = {
    nixpkgs.config.allowUnfree = true;

    _module.args = {
      inputs = inputs;
    };

    imports = [
      ../modules/home/zsh.nix
      ../modules/home/pkgs/age.nix
      ../modules/home/pkgs/bear.nix
      ../modules/home/pkgs/delta.nix
      ../modules/home/pkgs/emacs.nix
      ../modules/home/pkgs/flameshot.nix
      ../modules/home/pkgs/go.nix
      ../modules/home/pkgs/hyprland.nix
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

    home.username = "lv";
    home.homeDirectory = "/home/lv";

    home.packages = with pkgs; [
      git
    ];

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
  };
}
