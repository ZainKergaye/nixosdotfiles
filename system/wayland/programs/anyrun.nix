{ pkgs, lib, ... }:
let
  anyrun-bin = lib.getExe' pkgs.anyrun "anyrun";
in
{
  systemd.user.services.anyrun = {
    Unit = {
      Description = "Anyrun";
      After = "graphical-session.target";
      Wants = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${anyrun-bin} daemon";
      Restart = "always";
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, SPACE, exec, ${anyrun-bin}"
  ];

  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.3;
      };
      width = {
        fraction = 0.3;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = null;

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libwebsearch.so"
        "${pkgs.anyrun}/lib/libnix_run.so"
      ];
    };
    extraConfigFiles."websearch.ron".text = ''
      Config(
        prefix: ":? ",
        engines: [DuckDuckGo] 
      )
    '';
    extraConfigFiles."nix-run.ron".text = ''
      Config(
        prefix: ":r ",
        allow_unfree: false,
        channel: "nixpkgs-unstable",
        max_entries: 5,
      )
    '';
  };
}
