{ config, pkgs, lib, inputs, ... }:
{
  programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      colors = "auto";
      icons = "auto";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
        "--total-size"
        "--git-repos"
        "--sort=name"
        "--smart-group"
        "--modified"
        "--mounts"
        "--long"
        "--classify=auto"
        "--time-style=long-iso"
      ];
    };

    bat = {
      enable = true;
      config = {
        pager = "${pkgs.less}/bin/less -FR";
        theme = "base16";
      };
    };

    fd = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    dust
  ];
}
