{ config, pkgs, lib, inputs, ... }:
let
  languages = {
    markdown = import ./languages/markdown.nix { inherit pkgs lib; };
    toml = import ./languages/toml.nix { inherit pkgs lib; };
    nix = import ./languages/nixlang.nix { inherit pkgs lib; };
    json = import ./languages/json.nix { inherit pkgs lib; };
    yaml = import ./languages/yaml.nix { inherit pkgs lib; };
  };
  # Extract all packages
  allPackages = lib.flatten (lib.mapAttrsToList (_: lang: lang.packages) languages);

  # Extract all language configurations
  allLanguages = lib.mapAttrsToList (_: lang: lang.language) languages;

  # Merge all language servers
  allServers = lib.mkMerge (lib.mapAttrsToList (_: lang: lang.servers or { }) languages);

  # Collect all xdg config files from languages
  languageXdgConfigs = lib.mkMerge (
    lib.mapAttrsToList (_: lang: lang.xdgConfigFiles or { }) languages
  );

  # Collect dprint configurations from languages that use it
  dprintConfigs = lib.filterAttrs (_: lang: lang ? dprintConfig) languages;
  # Merge all dprint configs
  mergedDprintConfig = lib.mkMerge (lib.mapAttrsToList (_: lang: lang.dprintConfig) dprintConfigs);
in
{
  home.packages = with pkgs; [ ];

  # Helix editor configuration
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = allPackages;

    settings = (import ./settings.nix) // {
      theme = "catppuccin_transparant";
    };
    themes = {
      catppuccin_transparant = import ./themes/catppuccin-transparent.nix;
    };

    languages = {
      language = allLanguages;
      language-server = allServers;
    };
  };

  # Apply all language-specific XDG config files
  xdg.configFile = languageXdgConfigs // {
    # Global dprint configuration
    ".dprint.json" = {
      target = ".dprint.json";
      text = builtins.toJSON ({
        "$schema" = "https://dprint.dev/schemas/v0.json";
        plugins = [
          "https://plugins.dprint.dev/markdown-0.17.8.wasm"
          "https://plugins.dprint.dev/json-0.19.3.wasm"
          "https://plugins.dprint.dev/yaml-0.5.0.wasm"
        ];
        incremental = true;
        includes = [ "**/*.md" "**/*.markdown" "**/*.toml" "**/*.json" ];
        excludes = [
          "**/node_modules"
          "**/.git"
          "**/target"
          "**/dist"
          "**/*.min.json"
        ];
      } // mergedDprintConfig);
    };
  };
}
