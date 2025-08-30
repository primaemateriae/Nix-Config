{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/dolphin.nix
    ../components/nemo.nix
    ../components/desktop/terminal-emulator/wezterm.nix
    ../components/desktop/browsers/firefox.nix
    ../components/desktop/browsers/ungoogled-chromium.nix
    ../components/desktop/browsers/tor.nix
    ../components/desktop/password-manager/onepassword.nix
  ];
}
