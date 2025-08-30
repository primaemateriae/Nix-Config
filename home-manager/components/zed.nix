{ config, pkgs, lib, inputs, ... }:
{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
    ];

    userSettings = {
      auto_update = false;
      telemetry = {
        metrics = false;
        diagnostics = false;
      };

      vim_mode = false;
      helix_mode = true;

      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
      };

      buffer_font_size = 11;
      buffer_font_family = "Cozette";
      ui_font_size = 12;
      ui_font_family = "Cozette";
      hard_tabs = true;
      cursor_blink = true;

      show_whitespaces = "boundary";

      "experimental.theme_overrides" = {
        "editor_background.appearance" = "blurred";
        "editor.background" = "#00000000";
        "editor.gutter.background" = "#00000000";
        "surface.background" = "#00000000";
        "elevated_surface.background" = "#00000000";
        "panel.background" = "#00000000";
        "toolbar.background" = "#00000000";
        "tab_bar.background" = "#00000000";
        "title_bar.background" = "#00000000";
        "terminal.background" = "#00000000";
        "border" = "#00000000";
        "border.variant" = "#00000000";
      };
    };
  };
}

