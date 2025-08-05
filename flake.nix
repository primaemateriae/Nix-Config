{
  description = "Configuration Flakes for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # hyprland.url = "github:hyprwm/Hyprland";                 # Official Flake from Hyprland to use for the Hyprland package.
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
  nixosConfigurations = {
    gpd-pocket-3 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; };
      modules = [./hosts/gdp-pocket-3/configuration.nix];
    };
  };
   
  };
}
