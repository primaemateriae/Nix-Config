{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./file-tools/code-stats.nix
    ./web-tools/serving.nix
    ./fetchers/onefetch.nix
    ./monitors/bandwhich.nix
  ];
}
