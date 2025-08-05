{ config, pkgs, lib, inputs, ... }:
{
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    settings = {
      # workaround for https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with the file manager in use. 
        file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
      };
    };
  };
}
