# Nix Commands

## Nix Rebuild and Switch

To update and switch to a new configuration generation for Nix, run the following:

```{sh}
sudo nixos-rebuild switch --flake ~/nix-config/#<host>
```

Where `<profile>` should be the target host, such as `gpd-pocket-3`.

## Standalone Home-Manager Rebuild and Switch

To update and switch to a new configuration generation for a standablone Home-Manager, run the following:

```{sh}
home-manager switch --flake ~/nix-config/home-manager/#<profile>
```

Where `<profile>` should be the target profile, such as `main-nixos`.

## Checking Hashes

Nix Packages uses Subresource Integrity (SRI) for validation. Specifically it uses sha256-[base64]. A download can be verified either with the nix command

```{sh}
nix hash file <file-path>
```

or with openssl

```{sh}
openssl dgst -sha256 -binary <file-path> | base64
```

## Find the Path of a Package in the Nix Store

Sometimes it is useful to fine the exact path of a package in the store. To do so, simply run

```{sh}
nix eval --raw <channel>#<package>.outPath
```

A filled in example to get the path to the wget command would be:

```{sh}
nix eval --raw nixpkgs#wget.outPath
```

In conjunction with the record_output helper script I have defined, run

```{sh}
record_output nix eval --raw <channel>#<package>.outPath
cd $rout
```

to record the output path from the nix command into the `$rout` variable, and use it to change into the desired directorty.
