{ pkgs, lib }:
{
  packages = with pkgs; [ nil nixpkgs-fmt ];

  language = {
    name = "nix";
    language-servers = [ "nil" ];
    formatter = {
      command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
    };
    auto-format = true;
  };

  servers = {
    nil = {
      command = "nil";
    };
  };

}
