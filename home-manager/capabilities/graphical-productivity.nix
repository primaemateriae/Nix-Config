{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/desktop/emails/proton.nix
    ../components/desktop/emails/thunderbird.nix
    ../components/desktop/file-conversion/basics.nix
    ../components/desktop/office/libreoffice.nix
    ../components/desktop/editors/zed.nix
    ../components/desktop/editors/obsidian.nix
    ../components/desktop/raster-editors/krita.nix
  ];
}
