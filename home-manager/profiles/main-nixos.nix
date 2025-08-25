{ config, pkgs, lib, inputs, ... }:
{
  programs.home-manager.enable = true; # Let home-manager install and manage itself.

  imports = [
    ../capabilities/all-fonts_core.nix

    ../capabilities/tty-core.nix
    ../capabilities/tty-audio.nix
    ../capabilities/tty-development.nix
    ../capabilities/tty-fun.nix

    ../capabilities/wayland-core.nix
    ../capabilities/graphical-core.nix
    ../capabilities/graphical-productivity.nix
    ../capabilities/graphical-art.nix
    ../capabilities/graphical-open_source_games.nix

    ../capabilities/all-experimental.nix
  ];

  # fonts.fontconfig.enable = true; # Makes fonts avalible system wide

  # Information for Home-Manager about the users and paths to manage.

  home = {
    username = "main";
    homeDirectory = "/home/main";
    language = {
      base = "en_CA.UTF-8";
    };
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      gtk.enable = true;
      hyprcursor = {
        enable = true;
        size = 20;
      };
    };
  };


  # Any dotfiles which are managed as plain files
  home.file = { };

  # Environment variables explicitly sourced when using a shell provided by Home Manager.
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
