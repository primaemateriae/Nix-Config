{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    blender
  ];
}
