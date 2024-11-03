{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    golangci-lint
    golangci-lint-langserver
    gopls
  ];
}
