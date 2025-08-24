{ config, pkgs, lib, inputs, ... }:
{
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [
          "/home/main/Nix-Config/wallpapers/nix-wall.png"
          # "/home/main/nix-config/wallpapers/Kath.png"
          # "~/.config/home-manager/wallpapers/nix-wall.png"
          # "home/main/.config/home-manager/wallpapers/wall_8K.png"
        ];

        wallpaper = [
          ", /home/main/Nix-Config/wallpapers/nix-wall.png"
          # ", /home/main/nix-config/wallpapers/Kath.png"
          # ", ~/.config/home-manager/wallpapers/nix-wall.png"
          # ", home/main/.config/home-manager/wallpapers/wall_8K.png"
        ];
        ipc = "on";
      };
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900; # Seconds 
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
    hyprsunset = {
      enable = true;
      settings = {
        max-gamma = 100;

        profile = [
          # The timee to return to default. Profiles with the "identity" sets hyprsunset to as if it were not running
          {
            time = "6:00";
            identity = true;
          }
          {
            time = "22:00";
            temperature = 5000;
            gamma = 1.0;
            # gamma = 0.8;
          }
        ];
      };
    };
    hyprpolkitagent.enable = true;
  };
  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "/home/main/Nix-Config/wallpapers/nix-wall.png"; # Has to be an absolute path. 
            # path = "/home/main/nix-config/wallpapers/Kath.png"; # Has to be an absolute path. 
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(30, 30, 46)";
            outer_color = "rgb(88, 91, 112)";
            outline_thickness = 2;
            placeholder_text = "";
            shadow_passes = 1;
          }
        ];
      };
    };
  };
  # home.packages = with inputs.hyprland.packages.${pkgs.system}; [
  # hyprpicker
  # hyprland-qt-support
  # hyprsysteminfo
  # ];
}
