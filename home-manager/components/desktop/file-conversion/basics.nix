{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg-full
  ];
  programs.pandoc = {
    enable = true;
  };
}
