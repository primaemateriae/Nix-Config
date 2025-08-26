{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    jq # iio-hyprland needs jq to work correctly, but does not automatically pull it. 
    iio-hyprland
    grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland; # IMPORTANT: We are using the official custom flake from Hyprland.
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; # IMPORTANT: Make sure we are using their portal package to avoid caching issues.

    xwayland.enable = true; # Whether to enable XWayland.

    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default # Plugin for touch screen gestures 
      inputs.hyprgrass.packages.${pkgs.system}.hyprgrass-pulse # Integration with pulse-audio
    ];

    settings = {
      # Monitor configuration
      monitor = [
        "DSI-1,preferred,auto,1,transform,3" # This is the built-in screen for the GPD-Pocket-3. It needs 3 rotations due to the monitor's built-in orientation to be aligned to keyboard use.
        "DP-1, preferred, auto, 1" # Wacom Movink 13
        "HDMI-A-1, preferred, auto, 1" # Dell monitor
        ", preferred, auto, auto"
      ];

      # Program definitions
      "$terminal" = "${pkgs.wezterm}/bin/wezterm";
      "$fileManager" = "${pkgs.kdePackages.dolphin}/bin/dolphin";

      # "$menu" = "${pkgs.rofi}/bin/rofi -show drun -show-icons"; # Really wierd, not always opens at the center. TODO: Investigate why this does not work while plain rofi does.
      "$menu" = "rofi -show drun -show-icons";

      # Environment variables
      env = [
        "XCURSOR_SIZE,20"
        "HYPRCURSOR_SIZE,20"
      ];

      # General settings
      general = {
        gaps_in = 3;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration settingsme
      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animation settings
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Misc settings
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false; # If true, dsiabled the random Hyprland logo / anime girl background. :(
        disable_splash_rendering = true;
        # font_family = "{pkgs.}"
        middle_click_paste = true;
      };

      # Input configuration
      input = {
        # Keyboard Configurations
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        repeat_rate = 45; # Repeat rate for held down keys in hertz.
        repeat_delay = 250; # Delay interval before a held-down key is repeated in miliseconds.
        numlock_by_default = false; # Don't engage numlock.

        # Mouse Configurations
        left_handed = false;
        follow_mouse = 1; # Configre whether WM focus should follow the mouse. 1 means to change focus to the window under the cursor.
        sensitivity = 0; # Scale mouse sensitivity, betweem -1.0 and 1.0
        natural_scroll = false; # Scroll in the "correct" direction... yes I have been ruined by Macs.

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          tap-to-click = true;
          drag_lock = 2; # Enables sticky drag, which means drag does not drop if finger leaves the track pad.
        };

        touchdevice = {
          enabled = true; # Enables registering touch inputs.

          transform = 3; # Same as the display transform for the display settigns, we have to transform 3 due to the touch screen's manufactured orientation.
          output = "DSI-1";
        };

        tablet = {
          output = "DP-1";
        };

      };

      device = [
        {
          # GPD Pocket 3's Goodix touchscreen
          name = "gxtp7380:00-27c6:0113";
          enabled = true;
          transform = 3; # Rotate 270° to match DSI-1's transform
          output = "DSI-1"; # Bind to internal display only
        }
        {
          # Wacom Movink 13's touch input
          name = "wacom-movink-13-finger";
          enabled = true;
          transform = 0; # No rotation needed
          output = "DP-1"; # Bind to Wacom display only
        }
        {
          # Wacom pen (stylus) - more specific than global tablet setting
          name = "wacom-movink-13-pen";
          output = "DP-1"; # Pen input only on Wacom display
        }
        {
          # GPD's stylus if you ever use one
          name = "gxtp7380:00-27c6:0113-stylus";
          output = "DSI-1"; # Keep stylus on GPD screen
        }
        {
          name = "apple-inc.-magic-trackpad";
          sensitivity = 0.5;
          accel_profile = "adaptive"; # TODO accel profile needs to be customized to match the ergonomics on Apple computers. 
          # touchpad = {
          #   scroll_factor = 0.8;
          # };
        }
      ];

      # # Window rules for creative applications
      # windowrulev2 = [
      #   # Send creative apps to a special workspace
      #   "workspace special:creative, class:^(krita)$"
      #   "workspace special:creative, class:^(inkscape)$"
      #   "workspace special:creative, class:^(gimp|Gimp)$"
      #   "workspace special:creative, class:^(blender|Blender)$"

      #   # Additional rules for better tablet experience
      #   "fullscreen, class:^(krita)$" # Auto-fullscreen Krita
      #   "noblur, class:^(krita|inkscape|gimp)$" # Disable blur for performance
      #   "noshadow, class:^(krita|inkscape|gimp)$" # Disable shadows
      # ];

      # # Workspace configuration
      # workspace = [
      #   "special:creative, monitor:DP-1, default:true" # Creative workspace on Wacom
      # ];

      # Gestures https://wiki.hypr.land/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = true; # Enable workspace swipe gesture on touchpad
        workspace_swipe_fingers = 3; # How many fingers for the touchpad gesture
        workspace_swipe_distance = 1000; # The distance in px of the touchpad gesture
        workspace_swipe_create_new = true; # Whether a swipe right on the last workspace should create a new one.
        workspace_swipe_min_speed_to_force = 20; # Minimum speed in px per timepoint to force the change and ignoring cancel_ratio. This allows flicks. Setting to 0 will disable this mechanic.
        workspace_swipe_cancel_ratio = 0.3; # Percentage in [0.0, 1,0] of the swipe gesture that must be done to proceed.
        workspace_swipe_forever = false; # Swiping will not clamp at the neighboring workspaces but continue to the further ones.
      };

      # # Per-device config
      # device = {
      #   name = "apple-inc.-magic-trackpad";
      #   sensitivity = 0.5;
      #   accel_profile = "adaptive"; # TODO accel profile needs to be customized to match the ergonomics on Apple computers. 
      #   # touchpad = {
      #   #   scroll_factor = 0.8;
      #   # };
      # };

      # Main modifier
      "$mainMod" = "SUPER";
      "$windowMod" = "SUPER";
      # "$windowMod" = "CTRL";
      "$rescueMod" = "SUPER SHIFT CTRL";

      # "$terminal" = "${pkgs.wezterm}/bin/wezterm";

      # Keybindings
      bind = [
        # "exec, notify-send hello"
        "$rescueMod, Return, exec, $terminal" # This is meant as a rescue to bring up a terminal. Do not modify. Saves havinf to bring up a terminal emulator some other way.
        "$rescueMod, Q, exit," # This is meant as a rescut to exit hyprland. Do not modify. Saves having to quit to tty through other means.

        "CTRL, Q, killactive," # Closes (not kills) the active window. For true kill, use forcekillactive
        "CTRL SHIFT, Q, forcekillactive," # Kills (force closes) the active window to close.
        "$mainMod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
        "$mainMod, BackSpace, exec, ${pkgs.firefox}/bin/firefox"
        # "$mainMod, Return, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        # "$mainMod, delete, exec, ${pkgs.firefox}/bin/firefox"
        "$mainMod, L, exec, hyprlock --immediate"

        # "$mainMod, P, exec, hyprpicker --autocopy"
        "$mainMod, Space, exec, $menu"

        "$windowMod SHIFT, F, togglefloating,"
        "$windowMod SHIFT, P, pseudo,"
        "$windowMod SHIFT, J, togglesplit,"

        # Focus movement
        "$windowMod, left, movefocus, l"
        "$windowMod, right, movefocus, r"
        "$windowMod, up, movefocus, u"
        "$windowMod, down, movefocus, d"

        "$windowMod CTRL, left, swapwindow, l"
        "$windowMod CTRL, right, swapwindow, r"
        "$windowMod CTRL, up, swapwindow, u"
        "$windowMod CTRL, down, swapwindow, d"

        # Workspace switching
        "$windowMod, 1, workspace, 1"
        "$windowMod, 2, workspace, 2"
        "$windowMod, 3, workspace, 3"
        "$windowMod, 4, workspace, 4"
        "$windowMod, 5, workspace, 5"
        "$windowMod, 6, workspace, 6"
        "$windowMod, 7, workspace, 7"
        "$windowMod, 8, workspace, 8"
        "$windowMod, 9, workspace, 9"
        "$windowMod, 0, workspace, 10"

        "$windowMod, bracketleft,  workspace, e-1"
        "$windowMod, bracketright, workspace, e+1"

        # Move window to workspace
        "$windowMod CTRL, 1, movetoworkspace, 1"
        "$windowMod CTRL, 2, movetoworkspace, 2"
        "$windowMod CTRL, 3, movetoworkspace, 3"
        "$windowMod CTRL, 4, movetoworkspace, 4"
        "$windowMod CTRL, 5, movetoworkspace, 5"
        "$windowMod CTRL, 6, movetoworkspace, 6"
        "$windowMod CTRL, 7, movetoworkspace, 7"
        "$windowMod CTRL, 8, movetoworkspace, 8"
        "$windowMod CTRL, 9, movetoworkspace, 9"
        "$windowMod CTRL, 0, movetoworkspace, 10"

        # Screen Capture
        "SUPER SHIFT, 2, exec, grimblast save active --notify ~/Screenshots/grimblast-active-$(date +%F_%H-%M).png "
        "SUPER SHIFT, 3, exec, grimblast save screen --notify ~/Screenshots/grimblast-screen-$(date +%F_%H-%M).png"
        "SUPER SHIFT, 4, exec, grimblast save area --notify ~/Screenshots/grimblast-area-$(date +%F_%H-%M).png"

        # Special workspace (scratchpad)
        # "$mainMod, S, togglespecialworkspace, magic"
        # "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through workspaces
        "$windowMod, mouse_down, workspace, e-1"
        "$windowMod, mouse_up,   workspace, e+1"
      ];

      # Repeating Keybindings (repeats when held down)
      binde = [ ];

      # Lock-Pass Keybindings (works while locked)
      bindl = [
        # Media Controls
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"

        # Muting
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      # Lock-Pass Repeating Keybindings (works while locked and repeats)
      bindel = [
        # Audio Adjust
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        # Brightness Adjust
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Toggle Keybindings
      bindt = [ ];

      # Mouse Bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window Rules
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      # Startup Commands
      # exec-once = ''${startupScript}/bin/start'';
      exec-once = [
        "${pkgs.waybar}/bin/waybar &"
        "${pkgs.iio-hyprland}/bin/iio-hyprland DSI-1"
      ];
    };

    extraConfig = /*hypr*/''
      plugin {
        touch_gestures {
          sensitivity = 4.0 # Tablet screens usually need higher sensitivity
          workspace_swipe_fingers = 3 # Must be more than 3

          # swipe up from bottom edge
          hyprgrass-bind = , edge:d:u, exec, firefox

          # tap with 3 fingers
          hyprgrass-bind = , tap:3, exec, wezterm

          # # Quick test: 3-finger tap pops a Hyprland notification.
          # hyprgrass-bind = , tap:3, exec, hyprctl notify -1 1500 "rgb(7aa2f7)" "detected"
        }
        hyprgrass-pulse {
          # Along which edge to trigger the volume changer
          # Slide along the edge to adjust volume
          # One of: l, r, u, d
          edge = l
        }
      }
    '';
  };

  imports = [ ./ecosystem.nix ];
}
