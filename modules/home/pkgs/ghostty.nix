let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/88195a94f390381c6afcdaa933c2f6ff93959cb4.tar.gz";
    sha256 = "1fs25csg0lq3v34jdzxr2qdvnyvylimmfh0qxlf39h4j1hclvbyj";
  }) {
    system = "x86_64-linux";
  };
in {
  home.packages = [
    unstable.ghostty
  ];
}
