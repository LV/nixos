let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    sha256 = "0hmq3f1a5sf2cmx9zz9y0vav48g61b2kjyhsgi662vb7if7h3c1x";
  }) {
    system = "x86_64-linux";
    config = { allowUnfree = true; };
  };
in {
  home.packages = [
    unstable.spotify-player
  ];
}
