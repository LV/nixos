{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    openssh
  ];

  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };
}
