{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    elixir

    # Dependencies
    inotify-tools
  ];

  home.activation = {
    addNecessaryExports = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
      export PATH=$HOME//nix/store/7s7zb9pdzk6h6s6mchvf9cbbsg3j8sbd-erlang-25.3.2.13/lib/erlang/erts-13.2.2.10/bin:$PATH
      export PATH=$HOME//etc/profiles/per-user/lv/bin:$PATH
    '';
  };
}
