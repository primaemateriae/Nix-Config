{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./core/sh.nix
    ./core/neoposix.nix
    ./core/ssh.nix
    ./version-control/git.nix
    ./version-control/jujutsu.nix
    ./prompt/starship.nix
    ./editors/helix/helix.nix
    ./fetchers/macchina/macchina.nix
    ./monitors/bottom.nix
    ./file-tools/yazi.nix
    ./web-tools/communication.nix
    ./web-tools/data-transfer.nix
  ];
}
