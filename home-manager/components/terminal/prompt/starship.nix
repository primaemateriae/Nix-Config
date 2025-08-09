{ config, pkgs, lib, inputs, ... }:
{
  # Cross-platform (shell) Terminal Prompter. Permissive (ISC). Rust.
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # This is the format for the actual prompt to be made on the terminal. 
      format = ''
        $os$username$hostname$localip:$directory$git_branch$git_commit$git_status$git_metrics$nix_shell$rust$python$cmd_duration$time
         $character
      '';

      # Identity and Location
      os = {
        disabled = false;
        format = "[$symbol]($style) ";
        style = "bold white";
        # Sybols are defined at the bottom.
      };
      username = {
        format = "[$user]($style)";
        style_user = "#CF9FFF";
        style_root = "red";
        show_always = true;
      };
      hostname = {
        format = "[@$hostname$ssh_symbol]($style)";
        ssh_symbol = " ";
        style = "purple";
        ssh_only = false;
      };
      localip = {
        format = "[+$localipv4]($style)";
        style = "bold blue";
        ssh_only = false;
        disabled = false;
      };
      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        read_only_style = "bold red";
        read_only = "  ";
        truncation_length = 5;
        truncate_to_repo = true;
        truncation_symbol = ".../";
      };

      # GIT
      git_branch = {
        format = "[$symbol$branch$remote_branch]($style) ";
        symbol = ""; # Intentionally no space here.
        style = "#C06EFF";
      };
      git_commit = {
        format = "[($hash$tag)]($style) ";
        style = "yellow";
        only_detached = true;
        tag_disabled = true;
      };
      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "red";
        disabled = true;
      };
      git_metrics = {
        format = "([+$added]($added_style))([-$deleted]($deleted_style)) ";
        added_style = "green";
        deleted_style = "red";
        disabled = false;
      };

      # Languages and Package Managers
      nix_shell = {
        format = "[$symbol$state( ($name))]($style) ";
        symbol = " ";
        impure_msg = "[impure](red)";
        pure_msg = "[pure](green)";
        style = "#7FB9E1";
        heuristic = true;
        disabled = true; #Currently, this does not seem to work correctly even with heuristic.
      };
      rust = {
        format = "[$symbol($version )]($style) ";
        symbol = " ";
        style = "#CE412B";
      };
      python = {
        format = "[$symbol$pyenv_prefix($version )(($virtualenv) )](#4B8BBE) ";
        symbol = " ";
      };

      # Time 
      cmd_duration = {
        format = "[~$duration]($style) ";
        style = "bold yellow";
        min_time = 1000; # Show duration for commands longer than 1 seconds
      };
      time = {
        format = "at [$time]($style)";
        time_format = "%F,%T"; # No Timezaone
        # time_format = "%F,%T,%:z"; # With Timezone
        style = "bold green";
        use_12hr = false;
        utc_time_offset = "local";
        disabled = false;
      };

      # Indicator
      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
      };

      # OS Symbols
      os.symbols = {
        NixOS = "[](#7FB9E1)";
        Macos = "";
        Debian = "";
        Redox = "";

        # This is from the default symbols table.
        # AIX = "➿ ";
        # Alpaquita = "🔔 ";
        # AlmaLinux = "💠 ";
        # Alpine = "🏔️ ";
        # Amazon = "🙂 ";
        # Android = "🤖 ";
        # Arch = "🎗️ ";
        # Artix = "🎗️";
        # Bluefin = "🐟 ";
        # CachyOS = "🎗️ ";
        # CentOS = "💠 ";
        # DragonFly = "🐉 ";
        # Emscripten = "🔗 ";
        # EndeavourOS = "🚀 ";
        # Fedora = "🎩 ";
        # FreeBSD = "😈 ";
        # Garuda = "🦅 ";
        # Gentoo = "🗜️ ";
        # HardenedBSD = "🛡️ ";
        # Illumos = "🐦 ";
        # Kali = "🐉 ";
        # Linux = "🐧 ";
        # Mabox = "📦 ";
        # Manjaro = "🥭 ";
        # Mariner = "🌊 ";
        # MidnightBSD = "🌘 ";
        # Mint = "🌿 ";
        # NetBSD = "🚩 ";
        # Nobara = "🎩 ";
        # OpenBSD = "🐡 ";
        # OpenCloudOS = "☁️ ";
        # openEuler = "🦉 ";
        # openSUSE = "🦎 ";
        # OracleLinux = "🦴 ";
        # Pop = "🍭 ";
        # Raspbian = "🍓 ";
        # Redhat = "🎩 ";
        # RedHatEnterprise = "🎩 ";
        # RockyLinux = "💠 ";
        # Solus = "⛵ ";
        # SUSE = "🦎 ";
        # Ubuntu = "🎯 ";
        # Ultramarine = "🔷 ";
        # Unknown = "❓ ";
        # Uos = "🐲 ";
        # Void = "  ";
        # Windows = "🪟 ";
      };
    };
  };
}
