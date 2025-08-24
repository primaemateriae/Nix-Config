{ config, pkgs, lib, inputs, ... }:

{
  programs.rofi = {
      package = pkgs.rofi-wayland;                                                # Use the wayland fork.
      enable = true;
      theme = "/home/main/Nix-Config/home-manager/components/desktop/menu/rofi-spotlight-dark.rasi";
      # location = "bottom-right";
      # font = "Libertinus Serif";
      # location = "top";
      # font = "CozetteVecter";
      cycle = true;
      terminal = "${pkgs.wezterm}/bin/wezterm";
      modes = ["drun" "window" "ssh"];
      # extraConfig = {
      #   show-icons = true;
      # };
  };
}
