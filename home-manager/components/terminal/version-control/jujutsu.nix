{ config, pkgs, lib, inputs, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "primaemateriae";
        email = "primamateria@mysticmechanica.com";
      };
    };
  };


  home.packages = with pkgs; [
    meld
  ];
}

