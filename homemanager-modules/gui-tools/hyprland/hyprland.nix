# Hyprland settings remain Nix data; Home Manager generates hyprland.lua.
{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hyprbinds.nix
    ./colors.nix
    ./programs
    ./scripts
  ];
  options.hyprland-hm-config = {
    enable = lib.mkEnableOption "Hyprland Home Manager configuration";
    startupCommands = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Commands run once when Hyprland starts, rather than on config reload.";
    };
  };
  config = lib.mkIf config.hyprland-hm-config.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # NixOS provides the portal from the matching Hyprland input.  Avoid Home
      # Manager's legacy `hyprland` argument override, which unstable XDPH no
      # longer accepts.
      portalPackage = null;
      configType = "lua";
      xwayland.enable = true;
      settings = {
        mod._var = "SUPER";
        config = {
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            resize_on_border = true;
            layout = "dwindle";
          };
          input = {
            accel_profile = "custom 0.2144477506 0.000 0.307 0.615 1.077 1.539 2.002 2.505 3.208 3.910 4.613 5.315 6.018 6.720 7.423 8.125 8.828 9.530 10.233 10.935 12.387";
            touchpad = {
              natural_scroll = true;
              tap_to_click = true;
              clickfinger_behavior = true;
              scroll_factor = 0.3;
            };
          };
          misc.key_press_enables_dpms = true;
          dwindle.preserve_split = true;
          animations.enabled = true;
        };
        env = [
          {
            _args = [
              "XCURSOR_SIZE"
              "14"
            ];
          }
          {
            _args = [
              "HYPRCURSOR_SIZE"
              "14"
            ];
          }
          {
            _args = [
              "natural_scroll"
              "true"
            ];
          }
          {
            _args = [
              "QT_QPA_PLATFORMTHEME"
              "qt6ct"
            ];
          }
          {
            _args = [
              "force_default_wallpaper"
              "1"
            ];
          }
        ];
        gesture = {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        };
        monitor = [
          {
            output = "";
            mode = "preferred";
            position = "auto";
            scale = 1;
          }
          {
            output = "desc:LG Display 0x0521";
            mode = "1920x1080@60.02";
            position = "0x0";
            scale = 1;
          }
          {
            output = "desc:Acer Technologies VG270 TEGAA003851S";
            mode = "1920x1080@74.97";
            position = "-1920x0";
            scale = 1;
          }
          {
            output = "desc:Samsung Electric Company S34J55x H4LNB01778";
            mode = "3440x1440@74.98";
            position = "-760x-1440";
            scale = 1;
          }
          {
            output = "desc:Dell Inc. DELL U3415W PXF7986G10HL";
            mode = "preferred";
            position = "auto-up";
            scale = 1;
          }
          {
            output = "desc:Ancor Communications Inc VS278 J9LMQS077400";
            mode = "preferred";
            position = "auto-up";
            scale = 1;
          }
          {
            output = "desc:Sharp Corporation SHARP HDMI";
            mode = "preferred";
            position = "auto-up";
            scale = 1;
            mirror = "eDP-1";
          }
        ];
        curve = [
          {
            _args = [
              "winIn"
              {
                type = "bezier";
                points = [
                  [
                    0.1
                    1.0
                  ]
                  [
                    0.1
                    1.0
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "winOut"
              {
                type = "bezier";
                points = [
                  [
                    0.1
                    1.0
                  ]
                  [
                    0.1
                    1.0
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "smoothOut"
              {
                type = "bezier";
                points = [
                  [
                    0.5
                    0
                  ]
                  [
                    0.99
                    0.99
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "layerOut"
              {
                type = "bezier";
                points = [
                  [
                    0.23
                    1
                  ]
                  [
                    0.32
                    1
                  ]
                ];
              }
            ];
          }
        ];

        animation = [
          {
            leaf = "windowsIn";
            enabled = true;
            speed = 7;
            bezier = "winIn";
            style = "slide popin";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 3;
            bezier = "smoothOut";
            style = "slide";
          }
          {
            leaf = "windowsMove";
            enabled = true;
            speed = 7;
            bezier = "winIn";
            style = "slide";
          }
          {
            leaf = "workspacesIn";
            enabled = true;
            speed = 8;
            bezier = "winIn";
            style = "slide";
          }
          {
            leaf = "workspacesOut";
            enabled = true;
            speed = 8;
            bezier = "winOut";
            style = "slide";
          }
          {
            leaf = "layersIn";
            enabled = true;
            speed = 10;
            bezier = "winIn";
            style = "slide";
          }
          {
            leaf = "layersOut";
            enabled = true;
            speed = 3;
            bezier = "layerOut";
            style = "popin 50%";
          }
        ];

        window_rule = [
          {
            match.initial_title = "^(kitty)";
            opacity = "0.8 0.8";
          }
          {
            match.tag = "op100";
            opacity = "1 1";
          }
          {
            match.tag = "op80";
            opacity = "0.8 0.8";
          }
          {
            match.tag = "op60";
            opacity = "0.6 0.6";
          }
          {
            match.title = "^Open File$";
            float = true;
            center = true;
          }
          {
            match.title = "^Save File$";
            float = true;
            center = true;
          }
          {
            match.title = "^annotate_toolbar$";
            float = true;
            pin = true;
          }
          {
            match.title = "^Annotation - Zoom$";
            float = true;
            pin = true;
            no_blur = true;
            opaque = true;
          }
          {
            match.title = "^as_toolbar$";
            float = true;
            pin = true;
          }
          {
            match.title = "^zoom_linux_float_video_window$";
            float = true;
            pin = true;
          }
          {
            match.title = "^Select what to share$";
            center = true;
            float = true;
            size = "100 100";
          }
          {
            match.title = "^Bluetooth Devices$";
            center = true;
            float = true;
          }
          {
            match.class = "^nm-connection-editor$";
            float = true;
            center = true;
          }
          {
            match.class = "^org.gnupg.pinentry-qt$";
            dim_around = true;
            stay_focused = true;
          }
        ];
      };
      extraConfig = ''
        hl.on("hyprland.start", function()
        ${
          lib.concatMapStrings (
            command: "  hl.exec_cmd(${builtins.toJSON command})\n"
          ) config.hyprland-hm-config.startupCommands
        }end)
      '';
    };
    hyprland-hm-config.startupCommands = [
      "nm-applet"
      "blueman-applet"
      "awww-daemon"
    ];
  };
}
