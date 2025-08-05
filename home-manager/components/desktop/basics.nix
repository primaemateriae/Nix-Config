{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./file-manager/dolphin.nix
    ./terminal-emulator/wezterm.nix
    ./browsers/firefox.nix
    ./browsers/ungoogled-chromium.nix
    ./browsers/tor.nix
    ./password-manager/onepassword.nix
  ];
}
