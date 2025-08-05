{ pkgs, lib }:
{
  packages = with pkgs; [ taplo ];

  language = {
    name = "toml";
    language-servers = [ "taplo" ];
    formatter = {
      command = "${pkgs.taplo}/bin/taplo";
      args = [ "fmt" "-" ];
    };
    auto-format = true;
  };

  servers = {
    taplo = {
      command = "taplo";
      args = [ "lsp" "stdio" ];
    };
  };

}
