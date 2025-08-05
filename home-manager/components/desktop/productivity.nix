{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./emails/proton.nix
    ./emails/thunderbird.nix
    ./file-conversion/basics.nix
    ./office/libreoffice.nix
    ./editors/zed.nix
    ./raster-editors/krita.nix
  ];
}
