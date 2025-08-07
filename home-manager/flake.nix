{
  description = "Home-Manager Configuration Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland"; # Do not change Hyprland's Nixpkgs, as warned by the offocial hyprland documentations. This could break the cache.
    # hyprland.url = "github:hyprwm/Hyprland/v0.50.1"; # Do not change Hyprland's Nixpkgs, as warned by the offocial hyprland documentations. This could break the cache.

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; # Follow Hyprland.
    };

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
