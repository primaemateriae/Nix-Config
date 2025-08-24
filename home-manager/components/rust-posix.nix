{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    sudo-rs
    uutils-coreutils
  ];
}
