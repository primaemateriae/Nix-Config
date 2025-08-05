{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./raster-editors/krita.nix
    ./modelling/blender.nix
  ];
}
