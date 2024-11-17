# Fetching Tarball in Non-Impurely

If you try to fetching a tarball like this:
```nix
foobar = builtins.fetchTarball "https://github.com/foo/bar.tar.gz";
```

You will get an error. Because the tarball's contents can change, running the builds at different points in time can result in pulling in different tarballs and thus make your system non-reproducible.

To fix this, just add a `sha256` hash.

## Obtaining the `sha256` hash
### base-16 (hex):
```sh
nix-prefetch-url https://github.com/edolstra/flake-compat/archive/master.tar.gz
```

### base-32:
```sh
nix-prefetch-url --unpack https://github.com/edolstra/flake-compat/archive/master.tar.gz
```

## Adding the hash to your `.nix` file
```nix
foobar = builtins.fetchTarball {
  src = "https://github.com/foo/bar.tar.gz";
  sha256 = "<SHA256 OUTPUT>";
};
```
