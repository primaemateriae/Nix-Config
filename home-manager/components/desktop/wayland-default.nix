{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./desktops/hyprland/hyprland.nix
    ./widgets/waybar.nix
    ./menu/rofi.nix

    ./daemons/networks/network-manager-applet.nix
    ./daemons/media-control/playerctld.nix
    ./daemons/notifications/mako.nix
    ./daemons/bluetooth/blueman-applet.nix
    ./daemons/storage-device-DBus/udiskie.nix
    ./brightness-control/brightnessctl.nix
    ./global-clipboard/wl-clipboard.nix
  ];
}
