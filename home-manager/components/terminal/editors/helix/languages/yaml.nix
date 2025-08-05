{ pkgs, lib }:
{
  packages = with pkgs; [
    nodePackages.yaml-language-server
    dprint # or use prettier if you prefer
  ];

  language = {
    name = "yaml";
    language-servers = [ "yaml-language-server" ];
    formatter = {
      command = "${pkgs.dprint}/bin/dprint";
      args = [ "fmt" "--stdin" "yaml" ];
    };
    auto-format = true;
    indent = {
      tab-width = 2;
      unit = "  ";
    };
  };

  servers = {
    yaml-language-server = {
      command = "yaml-language-server";
      args = [ "--stdio" ];
      config = {
        yaml = {
          keyOrdering = false;
          format = {
            enable = true;
            singleQuote = false;
            bracketSpacing = true;
            proseWrap = "preserve";
            printWidth = 120;
          };
          validation = true;
          schemas = {
            # Kubernetes schemas
            "https://json.schemastore.org/kubernetes.json" = "/*.k8s.yaml";
            "https://json.schemastore.org/kustomization.json" = "kustomization.yaml";
            # GitHub Actions
            "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml,yaml}";
            "https://json.schemastore.org/github-action.json" = "action.{yml,yaml}";
            # Docker Compose
            "https://json.schemastore.org/docker-compose.json" = "docker-compose.{yml,yaml}";
            # GitLab CI
            "https://json.schemastore.org/gitlab-ci.json" = ".gitlab-ci.{yml,yaml}";
            # Ansible
            "https://json.schemastore.org/ansible-playbook.json" = "**/playbooks/*.{yml,yaml}";
            "https://json.schemastore.org/ansible-task.json" = "**/tasks/*.{yml,yaml}";
          };
          schemaStore = {
            enable = true;
            url = "https://www.schemastore.org/api/json/catalog.json";
          };
        };
      };
    };
  };

  # dprint configuration specific to YAML
  dprintConfig = {
    yaml = {
      lineWidth = 120;
      indentWidth = 2;
      quotes = "preferDouble";
      trailingCommas = "never";
      commentLine = "above";
      dashSpacing = "oneSpace"; # "- item" vs "-item"
      flowSequence = "preferSingleLine";
      flowMapping = "preferSingleLine";
      ignoreCommentDirective = "dprint-ignore";
    };
  };
}
