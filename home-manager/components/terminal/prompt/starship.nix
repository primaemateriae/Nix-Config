{ config, pkgs, lib, inputs, ... }:
{
  # Cross-platform (shell) Terminal Prompter. Permissive (ISC). Rust.
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # This is the format for the actual prompt to be made on the terminal. 
      format = ''
        $os$username$hostname$localip:$directory$git_branch$git_status$git_commit$git_metrics$rust$package$cmd_duration$time
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

      git_branch = {
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold red";
        format = "[$all_status$ahead_behind]($style) ";
      };

      cmd_duration = {
        min_time = 1000; # Show duration for commands longer than 1 seconds
        format = "[~$duration]($style) ";
        style = "bold yellow";
      };

      time = {
        disabled = false;
        format = "at [$time]($style) ";
        time_format = "%F,%T,%:z";
        style = "bold green";
        use_12hr = false;
        utc_time_offset = "local";
      };

      os.symbols = {
        NixOS = " ";
        Macos = " ";
        Debian = " ";
        Redox = " ";

        # This is the default symbols table.
        AIX = "➿ ";
        Alpaquita = "🔔 ";
        AlmaLinux = "💠 ";
        Alpine = "🏔️ ";
        Amazon = "🙂 ";
        Android = "🤖 ";
        Arch = "🎗️ ";
        Artix = "🎗️";
        Bluefin = "🐟 ";
        CachyOS = "🎗️ ";
        CentOS = "💠 ";
        DragonFly = "🐉 ";
        Emscripten = "🔗 ";
        EndeavourOS = "🚀 ";
        Fedora = "🎩 ";
        FreeBSD = "😈 ";
        Garuda = "🦅 ";
        Gentoo = "🗜️ ";
        HardenedBSD = "🛡️ ";
        Illumos = "🐦 ";
        Kali = "🐉 ";
        Linux = "🐧 ";
        Mabox = "📦 ";
        Manjaro = "🥭 ";
        Mariner = "🌊 ";
        MidnightBSD = "🌘 ";
        Mint = "🌿 ";
        NetBSD = "🚩 ";
        Nobara = "🎩 ";
        OpenBSD = "🐡 ";
        OpenCloudOS = "☁️ ";
        openEuler = "🦉 ";
        openSUSE = "🦎 ";
        OracleLinux = "🦴 ";
        Pop = "🍭 ";
        Raspbian = "🍓 ";
        Redhat = "🎩 ";
        RedHatEnterprise = "🎩 ";
        RockyLinux = "💠 ";
        Solus = "⛵ ";
        SUSE = "🦎 ";
        Ubuntu = "🎯 ";
        Ultramarine = "🔷 ";
        Unknown = "❓ ";
        Uos = "🐲 ";
        Void = "  ";
        Windows = "🪟 ";
      };
    };
  };
}
