{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    tor-browser
  ];
}
