{ config, pkgs, lib, inputs, ... }:
{
  # Allow fontconfig to discover fonts and configurations installed through home.packages and {command}nix-env.
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
      monospace = [ "IBM Plex Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  home.packages = with pkgs; [
    cozette

    libertinus
    source-serif

    ibm-plex
    geist-font

    font-awesome
    nerd-fonts.noto
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono
    nerd-fonts.dejavu-sans-mono
  ];
}
