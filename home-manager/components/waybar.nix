{ config, pkgs, lib, inputs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        mode = "dock";                      # Bar is permanebtly visible, but can react to inputs.
        position = "top";                   # Bar is at the top of screen.
        layer = "top";                      # Render the bar on top of other windows.
        height = 25;                        # Prefered Height for the bar.
        spacing = 1;                        # Size of gaps in between different modules.
        fixed-center = true;                # As much as possible, make the center modules be the true center of the screen.

        modules-left = [
          "custom/power"
          "power-profiles-daemon"
          "idle_inhibitor"
          "cpu"                             # CPU usage
          "memory"
          "temperature"
          "privacy"
          "systemd-failed-units"
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "mpd"
          "pulseaudio"
          # "wireplumber"
          # "tray"
          "battery"
          # "battery#bat2"
          "bluetooth"
          "network"
          "clock"
        ];

        "custom/power" = {
          # "format" = "  NixOS ";
          "format" = " NixOS";
      		"tooltip" = false;
      		"menu" = "on-click";
      		# "menu-file": "$HOME/.config/waybar/power_menu.xml", // Menu file in resources folder
      		"menu-actions" = {
      			"shutdown"  = "shutdown";
      			"reboot"    = "reboot";
      			"suspend"   = "systemctl suspend";
      			"hibernate" = "systemctl hibernate";
      		};
        };
        "power-profiles-daemon" = {
          "format" = "{icon}";
          "format-icons" = {
            "default"     = "MODE 󰆦";
            "performance" = "MODE 󰓅";
            "balanced"    = "MODE 󰗑";
            "power-saver" = "MODE 󰌪";
          };
          "tooltip-format" = "Power Profile: {profile}\nDriver: {driver}";
          "tooltip" = true;
        };
        "idle_inhibitor" = {
            "format" = "{icon}";
            "format-icons" = {
                "activated" = "IDLE ";
                "deactivated" = "IDLE ";
            };
        };
      "privacy" = {
      	"icon-spacing" = 4;
      	"icon-size" = 18;
      	"transition-duration" = 250;
      	"modules" = [
      		{
      			"type" = "screenshare";
      			"tooltip" = true;
      			"tooltip-icon-size" = 24;
      		}
      		{
      			"type" = "audio-out";
      			"tooltip" = true;
      			"tooltip-icon-size" = 24;
      		}
      		{
      			"type" = "audio-in";
      			"tooltip" = true;
      			"tooltip-icon-size" = 24;
      		}
      	];
      };
      "hyprland/workspaces" = {
          # disable-scroll = true;
          "all-outputs" = true;
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "format" = "{name} {icon}";
          "format-icons" = {
            # "1"       = "○";
            # "2"       = "○";
            # "3"       = "○";
            # "4"       = "○";
            # "5"       = "○";
            # "urgent"  = "!";
            "active"  = "◉";
            "default" = "○";
            "visible" = "";
          };
        };

        "hyprland/window" = {
          # "format" = " {app_id}";
          "format" = "{title}";
          # "format" = "{initialTitle}";
          "icon" = true;
          "icon-size" = 14;
          "seperate-outputs" = true;
        };

        "cpu" = {
            "format" = "CPU {usage}%";
            "tooltip" = false;
        };
        "memory" = {
            "format" = "RAM {}%";
        };
        "temperature" = {
          # "thermal-zone"     = 2;
          # "hwmon-path"       = "/sys/class/hwmon/hwmon2/temp1_input";
          "critical-threshold" = 80; #Celcius
          "format"             = "{temperatureC}°C {icon}";
          "format-critical"    = "!!{temperatureC}°C {icon}!!";
          "format-icons"       = ["" "" ""];
        };
        "mpd" = {
          "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
          "format-disconnected" = "Disconnected ";
          "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          "unknown-tag" = "N/A";
          "interval" = 5;
          "consume-icons" = {
              "on" = " ";
          };
          "random-icons" = {
            "off" = "<span color=\"#585b70\"></span> ";
            "on" = "  ";
          };
          "repeat-icons" = {
            # "on" = " ";
            "on" = "󰑖  ";
          };
          "single-icons" = {
            "on" = "󰑘  ";
          };
          "state-icons" = {
            "paused" = "";
            "playing" = "";
          };
          "tooltip-format" = "MPD (connected)";
          "tooltip-format-disconnected" = "MPD (disconnected)";
        };
        "pulseaudio" = {
            # "scroll-step" = 1, // %, can be a float
            "format" = "{volume}% {icon} {format_source}";
            "format-muted" = " {format_source}";
            "format-bluetooth" = "{volume}% {icon} {format_source}";
            "format-bluetooth-muted" = " {icon} {format_source}";
            "format-source" = "{volume}% ";
            "format-source-muted" = "";
            "format-icons" = {
                "headphone" = "";
                "hands-free" = "";
                "headset" = "";
                "phone" = "";
                "portable" = "";
                "car" = "";
                "default" = ["" "" ""];
            };
            "on-click" = "playerctl play-pause";
            # "on-click" = "pavucontrol";
        };
        "battery" = {
          "format"          = "{capacity}% {icon}";
          "format-alt"      = "{time} left {icon}";
          "format-charging" = "{capacity}% ";
          "format-charging-alt" = "{time} to full ";
          "format-plugged"  = "{capacity}% ";
          "format-full"     = "{capacity}% (Full) {icon}";
          "format-full-alt" = "{time} left {icon}";
          "format-icons"    = ["" "" "" "" ""];
        };
        "battery#bat2" = {
            "bat" = "BAT2";
        };
        "bluetooth" = {
        	"format" = "{status} ";
        	"format-disabled" = "{status} ";
        	"format-connected" = "{num_connections} {status} ";
        	# "format-connected" = " {num_connections} connected";
        	# "format-connected" = " {device_alias}";
        	# "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
        	"tooltip-format" = "{controller_alias}\t{controller_address}";
        	# "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
      		"tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        	"tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        	"tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
        "network" = {
          "format-wifi"         = "{essid} ({signalStrength}%) 󰖩";
          # "format-wifi"         = "{essid} ({signalStrength}%) {ipaddr} ";
          "format-ethernet"     = "{ifname}/{cidr} 󰈀";
          "format-linked"       = "{ifname} (No IP) ⚠";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt"          = "{ifname}: {ipaddr}/{cidr}";
          "tooltip-format"      = "{ifname} via {gwaddr}";
        };
        "clock" = {
          "format"              = "{:%a %d. %b %H:%M} ";
          "timezone"            = "America/Vancouver";
          # "format-alt"        = "{:%a %d. %b %H:%M}";
          "tooltip-format"      = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
      };
    };

    style = /*css*/ ''
      * {
          /*
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          */
          font-family: CozetteVector, Fira Code, monospace;
          font-size: 13px;
      }

      window#waybar {
          background-color: rgba(24, 24, 37, 0.6);
          /* border-bottom: 1px solid rgba(17, 17, 27, 0.5); */
          color: #cdd6f4;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #cdd6f4;
      }
      */

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #cdd6f4;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }

      /* you can set a style on hover for any module like this */
      #pulseaudio:hover {
          background-color: #a37800;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #cdd6f4;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #custom-power,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #bluetooth,
      #scratchpad,
      #power-profiles-daemon,
      #mpd {
          padding: 0 10px;
          /* color: #cdd6f4; */
          background-color: rgba (30, 30, 30, 0.3);
          /* background-color: #1e1e2e; */
          border: 1px solid rgba (49, 50, 68, 0.3);
          border-radius: 3px;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          color: #fab387;
      }

      #battery {
          color: #a6e3a1;
      }

      #battery.charging, #battery.plugged {
          color: #f9e2af;
      }

      @keyframes blink {
          to {
              background-color: #f38ba8;
              color: #1e1e2e;
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
          background-color: #ff0000;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #power-profiles-daemon {
          /*
          padding-right: 15px;
          */
      }

      #power-profiles-daemon.performance {
          color: #f38ba8;
      }

      #power-profiles-daemon.balanced {
          color: #89b4fa;
      }

      #power-profiles-daemon.power-saver {
          color: #a6e3a1;
      }

      label:focus {
          background-color: #cdd6f4;
      }

      #cpu {
          color: #74c7ec;
      }

      #memory {
          color: #f5c2e7;
      }

      #disk {
          background-color: #964B00;
      }

      #backlight {
          background-color: #7f849c;
      }

      #network {
          color: #cba6f7;
      }

      #network.disconnected {
          color: #7f849c;
      }

      #pulseaudio {
          color: #89dceb;
      }

      #pulseaudio.muted {
          color: #7f849c;
      }

      #bluetooth {
          color: #74c7ec;
      }

      #wireplumber {
          background-color: #f9e2af;
          color: #cdd6f4;
      }

      #wireplumber.muted {
          background-color: #7f849c;
      }

      #custom-media {
          background-color: #a6e3a1;
          color: #2a5c45;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          background-color: #a6e3a1;
      }

      #custom-media.custom-vlc {
          background-color: #ffa000;
      }

      #custom-power {
          color: #ffffff;
      }

      #temperature {
          color: #b4befe;
      }

      #temperature.critical {
          color: #f38ba8;
      }

      #tray {
          background-color: #89dceb;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
      }

      #idle_inhibitor {
          color: #a6adc8;
      }

      #idle_inhibitor.activated {
          color: #f38ba8;
      }

      #mpd {
          color: #f2cdcd;
      }

      #mpd.disconnected {
          color: #f38ba8;
      }

      #mpd.stopped {
          color: #7f849c;
      }

      #mpd.paused {
          color: #9399b2;
      }

      #language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #cdd6f4;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
      	background-color: transparent;
      }

      #privacy {
          padding: 0;
      }

      #privacy-item {
          padding: 0 5px;
          color: white;
      }

      #privacy-item.screenshare {
          background-color: #cf5700;
      }

      #privacy-item.audio-in {
          background-color: #1ca000;
      }

      #privacy-item.audio-out {
          background-color: #0069d4;
      }
    '';
  };
}
