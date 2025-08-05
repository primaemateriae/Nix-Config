{onfig, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # NixOS Settings
  nix = {
    gc = {
      automatic = true;                                                 # Automatically runs the NixOS GC
      dates = "weekly";                                                 # GC runs weekly, which is recommended by the module. 
      # randomizeDelaySec = "30min";                                      # Add a redomized delay before gc. Randomization helps break up scheduled tasks. 
      options = "--delete-older-than 30d";                              # Delete generations older than 30 days.
    };
    settings = {
      experimental-features = [ "nix-command" "flakes"];                # Turn on nix command and flakes. Very stable already for many years. Core to this system config.
      auto-optimise-store = true;                                       # Auto detect files in the store with identical content and replace them with a single copy.

      # Prebuilt Caches
      # substituters = ["https://hyprland.cachix.org"];
      # trusted-substituters = ["https://hyprland.cachix.org"];
      # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  # Nix Packages Configurations
  nixpkgs.config.allowUnfree = true;                                  # Allow unfree packages

  # Boot Process 
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;                       # Use the latest kernal.
    kernelParams = [
      "fbcon=rotate:1"                                                # Rotate the default screen orientation on GPD Pocket 3 due to manufacture orientation.
      "splash"
      "quiet"
    ];
    loader = {
      systemd-boot = {
        enable = true;                                                # EFI boot manager (formally gummiboot).
        consoleMode = "keep";                                         # Use the console mode from the firmware.
        configurationLimit = 50;                                      # Maximum number of generations of latest generations to show in the boot menu.
      };
      efi.canTouchEfiVariables = true;                                # Allow install process to touch EFFI boot variables.
      timeout = 10;                                                   # Seconds until loader boots the default menu item.
    };
  };

  # Virtual Console Configuratios
  console = {
    enable = true;                                                    # Who even has a physical terminal nowadays?
    earlySetup = true;                                                # Set console options as early as possible.

    # Console Fonts
    
    # font = "Lat2-Terminus16";                                       # Very good font, comes in base even for minimal install. 

    # packages = [pkgs.terminus_font];                                # More modern version fo terminus.
    # # font = "ter-u16n";                                              
    
    packages = [pkgs.spleen];                                         # Boxy font with nice round corners.
    font = "spleen-6x12";                                             
    # font = "spleen-16x32";                                          

    # packages = [pkgs.cozette];                                      # Converted psfu of cozette dbf w/ some hacks due to width issues. Only on unstable as of July 4 2025.
    # # font = "cozette6x13";                                           
  };

  # Hardware Specific Configurations and Optimizations
  hardware = {
    # Processor
    cpu.intel.updateMicrocode = true;                                 # Automatically update the microcode to prevent obscuere crashes and potential security issues.

    # Bluetooth
    bluetooth = {
      enable = true;                                                  # Enable bluetooth support so long as a bluetooth module is present on the machine. 
      powerOnBoot = true;                                             # Power up the bluetooth controller on boot. 
    };

    # Graphics 
    graphics.enable = true;                                           # Whether to enable hardware accelerated graphics drivers. Mostly set by the corresponding modules but no hard setting it here. 

  };

  # Swaps
  zramSwap.enable = true;                                             # Enable in-memory compressed devices and swap space. 

  # Networking Stack 
  networking = {
    hostName = "nixos-gpd-pocket-3";

    # wireless.enable = true;                                         # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;

    # Configure network proxyies
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall.enable = true;                                           # Enables the Firewall.
    firewall.allowedTCPPorts = [ ];                                   # List of ports open in the firewall to incoming TCP connections.
    firewall.allowedUDPPorts = [ ];                                   # List of ports open in the firewall to incoming UDP connections.
  };

  # Security Policies and Access Control  
  security = {
    rtkit.enable = true;                                              # Enable RealtimeKit to hand out realtime scheduling priorities. E.g. Needed for Pipewire to acquire realtime priority.
    polkit.enable = true;
    auditd.enable = true;                                             # Enable the Linux Audit Daemon

    # Pluggable Authentication Modules
    pam.services = {
      hyprlock = {
        enable = true;
      };
      login.enableGnomeKeyring = true;
      # greetd.enableGnomeKeyring = true; # if using greetd
    };
  };

  # X Desktop Group Specfiication and Desktop Integrations
  xdg.portal = {
    enable = true;                                                    # Enable the XDG Desktop Portal, a service for Flatpak and other desktop containment frameworks. 
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland                                     # Implements wlroots-specific protocols for interactions. Hyprland module already adds this but good to be explicit. 
      xdg-desktop-portal-gtk                                          # Fallback for interfaces not implemented by the hyprland protal such as file chooser dialogs. 
      # xdg-desktop-portal-wlr
    ];
    config = {                                                        # Ensure that hyprland portal takes precedence.
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };

  # System Services and Daemons 
  services = {
    # Printing and Scanning
    printing.enable = true;                                           # Enable the Common UNIX Printing System (CUPS) daemon to support printing documents.

    # Audio
    pulseaudio.enable = false;                                        # Disabled to use modern sound subsystem (e.g. pipewire).
    pipewire = {
      enable = true;                                                  # A new mulimedia server and framework for Linux.
      audio.enable = true;                                            # Use Pipewire as the primary sound server.
      alsa.enable = true;                                             # Enable the Advanced Linux Sound Architecture (ALSA) framework.
      alsa.support32Bit = true;                                       # Support 32 bit ALSA on 64 bit systems. 
      pulse.enable = true;                                            # Enable emulation of PulseAudio server. 
      jack.enable = true;                                             # Enable the JACK Audio Connection Kit (JACK), a low latency sound server for activity such as sound production.
      wireplumber.enable = true;                                      # Session and policy manager for Pipewire. E.g. allows volume control.
    };
    mpd.enable = true;                                                # Music Player Daemon

    # Secure Shell
    openssh.enable = true;                                            # Enable OpenSSH Daemon.
    fail2ban.enable = true;                                           # Daemon to ban hosts that causes multiple authentication errors.

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    blueman.enable = true;                                            # Full featured bluetooth manager written in Python with GTK.

    power-profiles-daemon.enable = true;                              # DBus daemon that allows changing system behaviour and governors on the fly based on profiles.

    fwupd = {
      enable = true;                                                  # Daemon to update firmware on Linux systems by connecting to the Linux Vendor Firmware Service (LVFS).
    };

    fstrim = {
      enable = true;                                                  # SSD Optimization by trimming unused blocks on mounted filesystem.              
    };

    # avahi = {
    #   enable = true;
    #   nssdns4 = true; 
    # };

    udisks2.enable = true;

    # Systemd Loginkind
    logind = {
      extraConfig = "HandlePowerKey=ignore";                          # Ignore the Power key on the keyboard.
    };

    gnome.gnome-keyring.enable = true;

    protonmail-bridge.enable = true;

    dbus.enable = true;
  };
    
  programs = {
    hyprland = {
      enable = true;                                                  # Independent dynamic tiling Wayland Compositor. 
      xwayland.enable = true;                                         # Allow X11 applications to still function in Wayland. 
      # package = inputs.hyprland.packages."${pkgs.system}".hyprland; # Use the Hyprland package from the official flake. Allows more control when installing plugins. 
    };

    git = {
      enable = true;                                                  # Distributed Version Control System
      lfs.enable = true;
      config = {
        user = {
          name = "primaemateriae";
          email = "primamateria@mysticmechanica.com";
        };
        init.defaultBranch = "master";
        # credential.helper = "libsecret";
      };
    };

    neovim = {
      enable = true;                                                  # Terminal Editor with vi motions. Permissive (Apache). Vim Script, Lua, C.
      viAlias = true;                                                 # Symlink vi to nvim.  
      vimAlias = true;                                                # Symlink vim to nvim.  
    };

    traceroute = {
      enable = true;
    };

    firejail = {
      enable = true;                                                  # SUID sandboxing program. 
    };

    seahorse.enable = true;                                           # GUI for managing keyring

    kde-pim = {
      enable = true;
      merkuro = true;
      kontact = true;
    };
  };

  # System-Wide Package Installs. Be minimal. 
  environment.systemPackages = with pkgs; [
    # System 
    home-manager                                                      # Delaratively and reproducable management of contents in user directories using the Nix language. Installed as standalone. 

    # Common Utilities    
    helix                                                             # Terminal Editor w/ Kakoune Motions. Rust.
    whois
    wget                                                              # Retreive content from web servers.
    file
    lsb-release
    usbutils
    pciutils
    cron
  ];

  # Time, Timezone, and Synchronization Settings.
  time.timeZone = "America/Vancouver";                                # TIme zone used when displaying times and dates. 

  # Language, Input, and Internationalization Settings. 
  i18n.defaultLocale = "en_GB.UTF-8";                                 # Default location to determin the languages for program messages, date and time formating, etc. 

  # Manage Users and Groups
  users = {
    # User Accounts. Set a password with passwd.
    users = {
      main = {
        description = "Main User of the Computer";                    # Main account. Mostly for single person systems. 
        isNormalUser = true;                                          # This is a real user and not a system user. 
        extraGroups = [ "networkmanager" "wheel" ];                   # User's Auxillary Groups. 
      };
    };
  };

  # System Environment Configurations
  environment = {
    # A list of global environment variables.
    sessionVariables = {
      NIXOS_OZONE_WL = "1";                                           # Enable Ozone Wayland to support Chromium/Electron Applications, otherwise they maynot display correctly. 
    };
  };
  
  # !!! PLEASE READ !!!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Before you change, did you read the comment?
}
