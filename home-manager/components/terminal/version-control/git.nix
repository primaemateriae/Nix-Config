{ config, pkgs, lib, inputs, ... }:
{
  # home.packages = with pkgs; [
  #   delta
  # ];

  programs.git = {
    enable = true;
    userName = "primaemateriae";
    userEmail = "primamateria@mysticmechanica.com";
    delta = {
      enable = true;
    };
  };
}
