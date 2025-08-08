{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./desktop/browsers/ladybird.nix
    ./desktop/editors/gedit.nix
  ];


  home.packages = with pkgs; [
    xh
    hexyl
    tealdeer
    # jj
    ytermusic
    youtube-tui
    jless
    inlyne
    dua
    hyperfine
    wiki-tui
    gitui
    mupdf
    kdePackages.gwenview
    kdePackages.okular
    sniffnet
    # kdePackages.merkuro
    gnome-calendar
    kdePackages.korganizer
    mediawriter

    fuc # Modern, performance focused unix commands
    duf # Disk Usage/Free Utility
    procs # Modern replacement for ps written in Rust
    # httpie # Command line HTTP client whose goal is to make CLI human-friendly
    xh # Friendly and fast tool for sending HTTP requests
    gnome-clocks
    # libretrack
    openssl
    xdg-utils
    signal-desktop
    fastfetch
    wthrr
  ];

  programs.clock-rs = {
    enable = true;
    settings = {
      general = {
        color = "magenta";
        interval = 250;
        blink = true;
        bold = true;
      };

      # position = {
      #   horizontal = "start";
      #   vertical = "end";
      # };

      date = {
        fmt = "%A, %B %d, %Y";
        use_12h = true;
        utc = true;
        hide_seconds = false;
      };
    };
  };


  # mpd
  # rmpc
  # ripgrep-all

  programs.imv = {
    enable = true;
    # settings = {};
  };

  programs.swayimg = {
    enable = true;
    # settings = {};
  };

  programs.mpv = {
    enable = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };
}
