{ config, pkgs, lib, inputs, ... }:
{
  xdg.configFile."macchina/themes" = {
    source = ./themes;
    # source = ./configs/macchina/themes;
    recursive = true;
  };
  xdg.configFile."macchina/macchina.toml".source = ./macchina.toml;
  # xdg.configFile."macchina/macchina.toml".source = ./configs/macchina/macchina.toml;
}
