# Nix Commands

## Nix Rebuild and Switch

To update and switch to a new configuration generation for Nix, run the following:

```{sh}
sudo nixos-rebuild switch --flake ~/nix-config/#<host>
```

Where `<profile>` should be the target host, such as `gpd-pocket-3`.

## Standalone Home-Manager Rebuild and Switch

To update and switch to a new configuration generation for a standalone Home-Manager, run the following:

```{sh}
home-manager switch --flake ~/nix-config/home-manager/#<profile>
```

Where `<profile>` should be the target profile, such as `main-nixos`.

## Checking Hashes

Nix Packages uses Sub-Resource Integrity (SRI) for validation. Specifically it uses sha256-[base64]. A download can be verified either with the nix command

```{sh}
nix hash file <file-path>
```

or with openssl

```{sh}
openssl dgst -sha256 -binary <file-path> | base64
```

## Ephemeral Packages
There are many times where one may only want a package temporarily. Perhapse the tool is seldom used. Perhpas one is only trying a tool out. 

To simply "run" a package, use `nix run`
```{sh}
# To install open source packages:
nix run <channel>#<package>

# To install proprietary packages, we need the --impure flag to inject the environmental variable
NIXPKGS_ALLOW_UNFREE=1 nix run --impure <channel>#<package>

# Filled in examples
nix run nixpkgs#espeak "hello"

NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#typora
```

To enter into a shell with the package instead of simply running it once, use `nix shell` instead.

## Find the Path of a Package in the Nix Store

Sometimes it is useful to fine the exact path of a package in the store. To do so, simply run

```{sh}
nix eval --raw <channel>#<package>.outPath

# Filled in example to grab wget from nixpkgs
nix eval --raw nixpkgs#wget.outPath
```

In conjunction with the record_output helper script I have defined, run

```{sh}
record_output nix eval --raw <channel>#<package>.outPath
cd $rout
```

to record the output path from the nix command into the `$rout` variable, and use it to change into the desired directory.
