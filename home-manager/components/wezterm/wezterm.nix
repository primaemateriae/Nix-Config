{ config, pkgs, lib, inputs, ... }:
{
  # Cross-platform Terminal Emulator. So good! Permissive (MIT) Rust.
  programs.wezterm = {
    enable = true;
    extraConfig = /*lua*/''
      return (function()
        ${builtins.readFile ./wezterm.lua}
      end)()
    '';
  };
  home.packages = with pkgs; [
    dragon-drop # Simple drag-and-drop source/sink for X or Wayland (called dragon in upstream)
  ];
}
