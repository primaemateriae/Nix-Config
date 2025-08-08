{ config, pkgs, lib, inputs, ... }:
{
  # Cross-platform (shell) Terminal Prompter. Permissive (ISC). Rust.
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # This is the format for the actual prompt to be made on the terminal. 
      format = ''
        $os$username$hostname$localip:$directory$git_branch$git_status$git_commit$git_metrics$nix_shell$rust$python$cmd_duration$time
         $character
      '';

      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
      };

      os = {
        disabled = false;
        format = "[$symbol]($style)";
        style = "bold white";
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
        ssh_only = false;
        style = "purple";
      };

      localip = {
        disabled = false;
        ssh_only = false;
        format = "[+$localipv4]($style)";
        style = "bold blue";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        read_only = "  ";
        read_only_style = "bold red";
        truncation_length = 5;
        truncate_to_repo = true;
        truncation_symbol = ".../";
      };

      cmd_duration = {
        min_time = 1000; # Show duration for commands longer than 1 seconds
        format = "[~$duration]($style) ";
        style = "bold yellow";
      };

      time = {
        disabled = false;
        format = "at [$time]($style) ";
        time_format = "%F,%T"; # No Timezaone
        # time_format = "%F,%T,%:z"; # With Timezone
        style = "bold green";
        use_12hr = false;
        utc_time_offset = "local";
      };

      # GIT
      git_branch = {
        style = "bold purple";
        format = "[$symbol$branch$remote_branch]($style) ";
      };
      git_commit = {
        format = "[($hash$tag)]($style) ";
        style = "green";
        only_detached = true;
        tag_disabled = true;
      };
      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "red";
        disabled = true;
      };
      git_metrics = {
        format = "([+$added]($added_style))([-$deleted]($deleted_style) )";
        added_style = "green";
        deleted_style = "red";
        disabled = false;
      };

      # Languages Etc.
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
        format = "[$symbol($version )]($style)";
        symbol = "";
        style = "#CE412B";
      };
      python = {
        format = "[$symbol$pyenv_prefix($version )(($virtualenv) )](#4B8BBE)";
        symbol = " ";
      };

      # OS Symbols
      os.symbols = {
        NixOS = "[](#7FB9E1) ";
        Macos = " ";
        Debian = " ";
        Redox = " ";

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
