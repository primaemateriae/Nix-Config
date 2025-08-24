{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/desktop/desktops/hyprland/hyprland.nix
    ../components/desktop/widgets/waybar.nix
    ../components/desktop/menu/rofi.nix

    ../components/desktop/daemons/networks/network-manager-applet.nix
    ../components/desktop/daemons/media-control/playerctld.nix
    ../components/desktop/daemons/notifications/mako.nix
    ../components/desktop/daemons/bluetooth/blueman-applet.nix
    ../components/desktop/daemons/storage-device-DBus/udiskie.nix
    ../components/desktop/brightness-control/brightnessctl.nix
    ../components/desktop/global-clipboard/wl-clipboard.nix
  ];
}
