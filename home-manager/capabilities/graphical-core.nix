{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/desktop/file-manager/dolphin.nix
    ../components/desktop/terminal-emulator/wezterm.nix
    ../components/desktop/browsers/firefox.nix
    ../components/desktop/browsers/ungoogled-chromium.nix
    ../components/desktop/browsers/tor.nix
    ../components/desktop/password-manager/onepassword.nix
  ];
}
