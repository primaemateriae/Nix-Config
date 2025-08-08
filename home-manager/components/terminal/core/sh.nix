{ config, pkgs, lib, inputs, ... }:
{
  # Bash will be used as the login/system/script shell.
  programs = {
    bash = {
      enable = true;
      # interactiveShellInit = ''
      #   ${pkgs.fish}/bin/fish
      # '';
    };

    # A NON-POSIXi compliant shell with batteries included (syntax highlight, 24b color, auto-complete).     Libre (GPL 2)           Rust, Shell.
    fish = {
      enable = true;
      generateCompletions = true;

      functions = {
        record_output = {
          description = "records the output of the last command";
          body = /*fish*/ ''
            set -g rout (eval $argv 2>&1)
            set -g rstatus $status
            echo $rout
            return $rstatus
          '';
        };
      };

      # Script called during interactive initialization.
      interactiveShellInit = /*fish*/''
        set -g fish_greeting
        set -gx EDITOR ${pkgs.helix}/bin/hx
        set -gx GEDITOR ${pkgs.zed-editor}/bin/zeditor
        set -gx BROWSER ${pkgs.firefox}/bin/firefox

      '';
      # Sleep is needed because otherwise maccina will be too fast for hyprland.
      # sleep 0.3

      # Shell script called during interactive initialisation last thing in startup.
      shellInitLast = /*fish*/''
        ${pkgs.starship}/bin/starship init fish | source
        ${pkgs.macchina}/bin/macchina
      '';

      shellAliases = {
        edit = "$EDITOR";
        gedit = "$GEDITOR";

        # vi = "nvim";
        # cd = "${pkgs.zoxide}/bin/z";
        cat = "${pkgs.bat}/bin/bat";

        # ls = "${pkgs.eza}/bin/eza --icons=auto --group-directories-first --total-size --git --git-repos --sort=name --smart-group --modified --mounts --classify=auto --time-style=long-iso --long ";
        # la = "${pkgs.eza}/bin/eza --icons=auto --group-directories-first --total-size --git --git-repos --sort=name --smart-group --modified --mounts --classify=auto --time-style=long-iso --long --all";
        # lt = "${pkgs.eza}/bin/eza --icons=auto --group-directories-first --total-size --git --git-repos --sort=name --smart-group --modified --mounts --classify=auto --time-style=long-iso --long --tree";

        mk = "touch";
        # mkdir = ""; # TODO
        # fm     = "yy"
        find = "${pkgs.fd}/bin/fd";
        grep = "${pkgs.ripgrep}/bin/rg";
        fetch = "${pkgs.macchina}/bin/macchina";
        mon = "${pkgs.bottom}/bin/btm";
        serve = "${pkgs.miniserve}/bin/miniserve";
        drop = "${pkgs.dragon-drop}/bin/dragon-drop --on-top --and-exit";

        icat = "${pkgs.wezterm}/bin/wezterm imgcat";

        exitde = "${pkgs.hyprland}/bin/hyprctl dispatch exit"; # Exits the desktop environment. Currently this is a little brute-force. TODO: graceful shutdown of windows.
      };

      shellAbbrs = {
        t = "touch";
        ro = "record_output";
        symlink = "ln -s";
        pathof = "readlink -f";

        gs = "${pkgs.git}/bin/git status";
        ga = "${pkgs.git}/bin/git add";
        gc = "${pkgs.git}/bin/git commit -m \"\"";
        gac = "${pkgs.git}/bin/git commit -am \"\"";
        gp = "${pkgs.git}/bin/git push";
        gl = "${pkgs.git}/bin/git log --online --graph";
      };
    };
  };
}
