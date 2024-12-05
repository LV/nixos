{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g prefix C-Space
    '';
  };
}
