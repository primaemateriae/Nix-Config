{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard           # Wayland Clipboard Bridge.
  ];
}
