{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/code-stats.nix
    ../components/terminal/web-tools/serving.nix
    ../components/onefetch.nix
    ../components/bandwhich.nix

    # JSON
    ../components/jless.nix

    # Calculation
    ../components/fend.nix
  ];
}
