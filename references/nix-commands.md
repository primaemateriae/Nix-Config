# Nix Commands

## Nix Rebuild and Switch

To update and switch to a new configuration generation for Nix, run the following:

```{bash}
sudo nixos-rebuild switch --flake ~/nix-config/#<host>
```

Where `<profile>` should be the target host, such as `gpd-pocket-3`.

## Standalone Home-Manager Rebuild and Switch

To update and switch to a new configuration generation for a standablone Home-Manager, run the following:

```{bash}
home-manager switch --flake ~/nix-config/home-manager/#<profile>
```

Where `<profile>` should be the target profile, such as `main-nixos`.

## Checking Hashes

Nix Packages uses Subresource Integrity (SRI) for validation. Specifically it uses sha256-[base64]. A download can be verified wither with

```{bash}
nix hash file <file-path>
```

or with

```{bash}
openssl dgst -sha256 -binary <file-path> | base64
```
