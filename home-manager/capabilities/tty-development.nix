{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/terminal/file-tools/code-stats.nix
    ../components/terminal/web-tools/serving.nix
    ../components/terminal/fetchers/onefetch.nix
    ../components/terminal/monitors/bandwhich.nix

    # JSON
    ../components/terminal/pagers/jless.nix
  ];
}
