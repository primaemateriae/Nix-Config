{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    # controlMaster = "auto";
    # controlPersist = "10m";

    matchBlocks = {
      # Primae Materiae GitHub 
      "gh-primaemateriae" = {
        host = "gh-primaemateriae";
        hostname = "github.com";
        user = "git"; # Don't change this, this is not the github username, but the connection username, which should always be git. Identity is defined by the ssh key.
        identityFile = "~/.ssh/id_ed25519_gh-primaemateriae";
        identitiesOnly = true;
      };
    };
  };

  services.ssh-agent.enable = true;
}
