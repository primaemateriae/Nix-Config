{ pkgs, lib }:
{
  packages = with pkgs; [ rust-analyzer rustfmt clippy ];

  language = {
    name = "rust";
    language-servers = [ "rust-analyzer" ];
    formatter = {
      command = "${pkgs.rustfmt}/bin/rustfmt";
      args = [ "--edition" "2021" ];
    };
    auto-format = true;
    indent = {
      unit = "t";
      tab-width = 4;
    };
  };

  servers = {
    rust-analyzer = {
      command = "rust-analyzer";
      config = {
        checkOnSave = {
          command = "clippy";
        };
        cargo = {
          features = "all";
        };
        # Minimal config that works across most projects
        inlayHints = {
          bindingModeHints.enable = true;
          closingBraceHints.minLines = 25;
          closureReturnTypeHints.enable = "always";
          lifetimeElisionHints.enable = "skip_trivial";
          typeHints.enable = true;
        };
      };
    };
  };

}
