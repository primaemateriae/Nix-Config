{ config, pkgs, lib, inputs, ... }:
{
  programs = {
    fuzzel = {
      enable = true;
      settings = {
        main = {
          layer = "overlay";
          width = 50;
          # line-height = 50;
          font = "Fira Code";
          # font = "CozetteVector";
          # font = "CozetteVector:size=10";
          terminal = "${pkgs.wezterm}/bin/wezterm";
          prompt = "❯   ";
          show-actions = "yes";
          exit-on-keyboard-focus-loss="no";
        };
        colors = {
          background = "282a36fa";
          selection  = "3d4474fa";
          border     = "fffffffa";
        };
        border = {
          radius = 20;
        };
        dmenu = {
          exit-immediately-if-empty="yes";
        };
      };
    };
  };
}
