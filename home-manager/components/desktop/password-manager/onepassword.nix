{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    _1password-gui
  ];
}
