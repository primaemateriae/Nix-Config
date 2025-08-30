{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/proton.nix
    ../components/thunderbird.nix
    ../components/desktop/file-conversion/basics.nix
    ../components/libreoffice.nix
    ../components/zed.nix
    ../components/obsidian.nix
    ../components/krita.nix
  ];
}
