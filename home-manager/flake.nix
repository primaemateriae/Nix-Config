{
  description = "Home-Manager Configuration Flakes";

  inputs = {
    # Using unstable channel for the freshes packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Declarative configuration of user specific packages and dotfiles. here installed as a standalone for non-sudo switches.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Official flake for Hyprland from developpers. More cutting edge and maintains versions compatability with plugins.
    hyprland.url = "github:hyprwm/Hyprland"; # Do not change Hyprland's Nixpkgs (e.g. follows nixpkgs), as warned by the offocial hyprland documentations. Could force one to source compile.

    # Official hyprland plugins. https://github.com/hyprwm/hyprland-plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; # Important that this follows Hyprland so that the version of plugins will play nicely.
    };

    # Community Plugin for touch screen gestures on Hyprland. https://github.com/horriblename/hyprgrass
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # keep it in sync
    };

    # Community mained packages for firefox addons. 
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, hyprland-plugins, ... }@inputs:
    let
      system = "x86_64-linux";

      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      allowUnfree = true;
      homeConfigurations = {
        main-nixos = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./profiles/main-nixos.nix ];
        };
      };
    };
}
