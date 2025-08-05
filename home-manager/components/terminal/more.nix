{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./audio/text-to-speech.nix
  ];
}
