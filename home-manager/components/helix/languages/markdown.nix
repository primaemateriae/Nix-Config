{ pkgs, lib }:
{
  packages = with pkgs; [ markdown-oxide dprint ];

  language = {
    name = "markdown";
    scope = "source.md";
    injection-regex = "md|markdown";
    file-types = [ "md" "markdown" ];
    roots = [ ".markdown-oxide.toml" ];
    language-servers = [ "markdown-oxide" ];
    formatter = {
      command = "${pkgs.dprint}/bin/dprint";
      args = [ "fmt" "--stdin" "md" ];
    };
    auto-format = true;
    indent = {
      tab-width = 4;
      unit = " ";
    };
    comment-tokens = [ "-" "+" "*" "1." ">" "- [ ]" ];
    auto-pairs = {
      # "`" = "`";
    };
  };

  servers = {
    markdown-oxide = {
      command = "markdown-oxide";
    };
  };

  # dprint configuration specific to markdown
  dprintConfig = {
    markdown = {
      lineWidth = 200;
      textWrap = "always";
      emphasisKind = "asterisks";
      strongKind = "asterisks";
      unorderedListKind = "dashes";
      ignoreDirective = "dprint-ignore";
      ignoreStartDirective = "dprint-ignore-start";
      ignoreEndDirective = "dprint-ignore-end";
    };
  };

}
