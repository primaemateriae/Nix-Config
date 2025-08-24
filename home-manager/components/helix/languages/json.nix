{ pkgs, lib }:
{
  packages = with pkgs; [
    nodePackages.vscode-langservers-extracted # for vscode-json-language-server
    dprint
  ];

  language = {
    name = "json";
    language-servers = [ "vscode-json-language-server" ];
    formatter = {
      command = "${pkgs.dprint}/bin/dprint";
      args = [ "fmt" "--stdin" "json" ];
    };
    auto-format = true;
  };

  servers = {
    vscode-json-language-server = {
      command = "vscode-json-language-server";
      args = [ "--stdio" ];
      config = {
        json = {
          validate = { enable = true; };
          schemas = [
            # Common JSON schemas
            {
              fileMatch = [ "package.json" ];
              url = "https://json.schemastore.org/package.json";
            }
            {
              fileMatch = [ "tsconfig.json" "tsconfig.*.json" ];
              url = "https://json.schemastore.org/tsconfig.json";
            }
            {
              fileMatch = [ ".prettierrc" ".prettierrc.json" ];
              url = "https://json.schemastore.org/prettierrc.json";
            }
            {
              fileMatch = [ ".eslintrc" ".eslintrc.json" ];
              url = "https://json.schemastore.org/eslintrc.json";
            }
            {
              fileMatch = [ "composer.json" ];
              url = "https://json.schemastore.org/composer.json";
            }
          ];
        };
      };
    };
  };

  # dprint configuration specific to JSON
  dprintConfig = {
    json = {
      lineWidth = 120;
      indentWidth = 2;
      useTabs = false;
      trailingCommas = "never";
      preferSingleLine = false;
    };
  };
}
