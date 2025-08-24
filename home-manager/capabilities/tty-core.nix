{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../components/terminal/core/sh.nix
    ../components/terminal/core/neoposix.nix
    ../components/terminal/core/ssh.nix
    ../components/terminal/version-control/git.nix
    ../components/terminal/version-control/jujutsu.nix
    ../components/terminal/prompt/starship.nix
    ../components/terminal/editors/helix/helix.nix
    ../components/terminal/fetchers/macchina/macchina.nix
    ../components/terminal/monitors/bottom.nix
    ../components/terminal/file-tools/yazi.nix
    ../components/terminal/web-tools/communication.nix
    ../components/terminal/web-tools/data-transfer.nix
  ];
}
