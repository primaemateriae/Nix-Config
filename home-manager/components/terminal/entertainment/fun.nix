{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    cbonsai
    cmatrix
    genact
    lolcat
    pipes-rs
  ];
}
