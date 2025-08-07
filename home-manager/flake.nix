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
    hyprland.url = "github:hyprwm/Hyprland"; # IMPORTANT: Official docs disuades against changing Hyprland's Nixpkgs (e.g. follows nixpkgs). Could cause ABI incompatabilities and source compilation.

    # Official hyprland plugins. https://github.com/hyprwm/hyprland-plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT: Do not change. Follow hyprland's flake to ensure ABI compatability. 
    };

    # Community Plugin for touch screen gestures on Hyprland. https://github.com/horriblename/hyprgrass
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT: Do not change. Follow hyprland's flake to ensure ABI compatability. 
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
