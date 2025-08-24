{ config, pkgs, lib, inputs, ... }:
{
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        rate = 250; # The update rate of the application in miliseconds (fastest is 250ms).
        temperature_type = "celsius"; # Sets the temperature unit type.
        enable_gpu = true; # Shows GPU(s) information
        enable_cache_memory = true; # Shows cache and buffer memory

        # battery = true               # Show the battery widgets
      };

      processes = {
        columns = [ "PID" "Name" "CPU%" "Mem%" "R/s" "W/s" "GPU%" "GMem%" "User" "State" "time" ];
      };

      styles = {
        widgets = {
          border_color = "gray";
          selected_border_color = "255, 0, 255";
          widget_title = { color = "magenta"; };
          text = { color = "gray"; };
          selected_text = { color = "black"; bg_color = "light blue"; };
          disabled_text = { color = "dark gray"; };
        };

        tables = {
          headers = { color = "light blue"; bold = true; };
        };

        graphs = {
          graph_color = "gray";
          legend_text = { color = "light blue"; };
        };

        cpu = {
          all_entry_color = "grey";
          avg_entry_color = "255, 0, 255";
          # avg_entry_color = "255, 0, 0";
          # avg_entry_color = "255, 255, 255";
          # cpu_core_colors = [ "red" "green" "blue" "cyan" "magenta" ];
          cpu_core_colors = [ "grey" ];
        };

        memory = {
          ram_color = "light green";
          cache_color = "light yellow";
          swap_color = "light red";
          arc_color = "light cyan";
          gpu_colors = [ "light blue" "light red" "cyan" "green" "blue" "red" ];
        };

        network = {
          rx_color = "cyan";
          tx_color = "magenta";
          rx_total_color = "light cyan";
          tx_total_color = "light green";
        };

        battery = {
          high_battery_color = "green";
          medium_battery_color = "yellow";
          low_battery_color = "red";
        };
      };

      colors = {
        low_battery_color = "red";
      };
    };
  };
}
