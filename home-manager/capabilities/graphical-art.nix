{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/desktop/raster-editors/krita.nix
    ../components/desktop/modelling/blender.nix
    ../components/aseprite.nix
  ];
}
