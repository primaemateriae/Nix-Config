{ config, pkgs, lib, inputs, ... }:
{
  programs.thunderbird = {
    enable = true;
    profiles.main = {
      isDefault = true;
    };
  };
}
