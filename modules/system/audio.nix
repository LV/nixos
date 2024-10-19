{ pkgs, ... }:

{
  # Disable PulseAudio to prevent conflicts with PipeWire
  hardware.pulseaudio.enable = false;

  # Add necessary audio packages to the system environment
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol  # PulseAudio volume control UI
    pipewire
  ];

  # Configure PipeWire services
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;  # Enable JACK support
  };

  # TODO: Add protection to your speakers! You can go over 500% in max volume and you'll undoubtedly break them
}
