{ config, pkgs, lib, inputs, ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "fm";
  };
}
