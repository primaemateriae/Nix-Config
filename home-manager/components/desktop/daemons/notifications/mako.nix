{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    libnotify
  ];
  services.mako = {
    enable = true;
    settings = {
      actions = true;
      anchor = "top-right";
      background-color = "#1e1e2e";
      border-color = "#cdd6f4";
      border-radius = 3;
      default-timeout = 3000; # Miliseconds
      font = "Fira Code";
      # font = "monospace 10";
      height = 200;
      width = 300;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 20;
      markup = true;

      # Section example
      "actionable=true" = {
        anchor = "top-left";
      };
    };
  };
}
