{
  editor = {
    line-number = "absolute";
    text-width = 200;
    rulers = [ 201 ];
    auto-completion = true;
    auto-format = true;
    auto-pairs = true;
    cursorline = true;
    cursorcolumn = true;
    undercurl = true;
    completion-trigger-len = 2;
    color-modes = true;
    scrolloff = 5;
    mouse = true;
    middle-click-paste = true;

    cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };

    indent-guides = {
      # render = false;
      render = true;
      # character = "";
      character = "│";
      skip-levels = 0;
    };

    whitespace = {
      render = {
        space = "none";
        tab = "all";
        newline = "none";
        nbsp = "none";
      };
      characters = {
        space = "·";
        tab = "→";
        tabpad = " ";
        # tabpad = "·";
        nbsp = " ";
        nnbsp = " ";
        newline = " ";
      };
    };

    lsp = {
      display-inlay-hints = true;
      display-messages = true;
      auto-signature-help = true;
    };

    inline-diagnostics = {
      cursor-line = "hint";
    };

    statusline = {
      left = [ "mode" "spinner" "file-name" "file-modification-indicator" ];
      center = [ "diagnostics" "workspace-diagnostics" ];
      right = [ "selections" "position" "position-percentage" "file-encoding" ];
      mode = {
        normal = "NAVIGATION";
        insert = "AMENDATION";
        select = "VSELECTION";
      };
    };

    file-picker = {
      hidden = false;
      parents = true;
      ignore = true;
      git-ignore = true;
      git-global = true;
      git-exclude = true;
      max-depth = 10;
    };

    search = {
      smart-case = true;
    };
  };

  keys = {
    normal = {
      # Swap Line Functionality
      "A-up" = [ "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" ];
      "A-down" = [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
    };

    insert = {
      "A-up" = [ "normal_mode" "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "insert_mode" ];
      "A-down" = [ "normal_mode" "extend_to_line_bounds" "delete_selection" "paste_after" "insert_mode" ];
    };

    select = {
      "A-up" = [ "normal_mode" "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "select_mode" ];
      "A-down" = [ "normal_mode" "extend_to_line_bounds" "delete_selection" "paste_after" "select_mode" ];
    };
  };
}
