{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    playerctl 
  ];
  services.playerctld.enable = true;
}
