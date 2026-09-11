{
  config,
  lib,
  pkgs,
  system,
  ...
}:

let
  monitorName = "weylus-ipad";
  monitorMode = "1920x1440@30";
	monitorZoom = "1.5";

  weylusToggle = pkgs.writeShellApplication {
    name = "weylus-toggle";

    runtimeInputs = with pkgs; [
      hyprland
      jq
      procps
      systemd
    ];

    text = ''
      monitor_exists() {
        hyprctl -j monitors all 2>/dev/null \
          | jq -e --arg name ${lib.escapeShellArg monitorName} \
              'any(.[]; .name == $name)' >/dev/null
      }

      refresh_waybar() {
        pkill -RTMIN+8 waybar 2>/dev/null || true
      }

      stop_weylus() {
        systemctl --user stop weylus-ipad.service 2>/dev/null || true

        if monitor_exists; then
          hyprctl output remove ${lib.escapeShellArg monitorName} >/dev/null
        fi

        refresh_waybar
      }

      start_weylus() {
        if ! monitor_exists; then
          hyprctl output create headless ${lib.escapeShellArg monitorName} >/dev/null
        fi

        if ! hyprctl keyword monitor \
          ${lib.escapeShellArg "${monitorName},${monitorMode},auto-left,${monitorZoom}"} >/dev/null; then
          hyprctl output remove ${lib.escapeShellArg monitorName} >/dev/null 2>&1 || true
          exit 1
        fi

        if ! systemctl --user start weylus-ipad.service; then
          hyprctl output remove ${lib.escapeShellArg monitorName} >/dev/null 2>&1 || true
          exit 1
        fi

        refresh_waybar
      }

      case "''${1:-toggle}" in
        status)
          if systemctl --user --quiet is-active weylus-ipad.service \
            || monitor_exists; then
            jq -cn '{
						  text: "",
							alt: "activated",
							tooltip: "Weylus iPad display: on\nClick to stop",
							class: "activated"
            }'
          else
            jq -cn '{
						  text: "",
							alt: "deactivated",
							tooltip: "Weylus iPad display: off\nClick to start",
							class: "deactivated"
            }'
          fi
          ;;
        start)
          start_weylus
          ;;
        stop)
          stop_weylus
          ;;
        toggle)
          if systemctl --user --quiet is-active weylus-ipad.service \
            || monitor_exists; then
            stop_weylus
          else
            start_weylus
          fi
          ;;
        *)
          echo "usage: weylus-toggle [status|start|stop|toggle]" >&2
          exit 2
          ;;
      esac
    '';
  };

  system = "x86_64-linux";

  w-pkgs = import (builtins.fetchGit {
    name = "weylus-bump";
    url = "https://github.com/ZainKergaye/nixpkgs/";
    ref = "refs/heads/weylus-bump";
    rev = "5825be3485ad3ec65c4dfb8f53a522e7710e71a8";
  }) { inherit system; };

  weylus-bumped = w-pkgs.weylus;

  palette = config.colorScheme.palette;
in
{
  config = lib.mkIf config.hyprland-hm-config.enable {

    wayland.windowManager.hyprland.settings.monitor = [
      "${monitorName}, ${monitorMode}, auto-left, ${monitorZoom}"
    ];
    home.packages = [
      weylus-bumped
      weylusToggle
    ];

    systemd.user.services.weylus-ipad = {
      Unit = {
        Description = "Weylus for the iPad virtual monitor";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe weylus-bumped}";
      };
    };

    programs.waybar.settings.mainBar = {
      "group/poweroptions".modules = lib.mkAfter [ "custom/weylus" ];

      "custom/weylus" = {
        exec = "${lib.getExe weylusToggle} status";
        on-click = "${lib.getExe weylusToggle} toggle";
        return-type = "json";
        format = "{icon}";
        "format-icons" = {
          activated = "󰦉 ";
          deactivated = "󰥍 ";
        };
        interval = 2;
        signal = 8;
      };
    };

    # 0B = green
    # 0F = Dark red
    programs.waybar.style = lib.mkAfter ''
			#custom-weylus.activated {
        color: #${palette.base0B};
      }

			#custom-weylus.deactivated {
        color: #${palette.base0F};
      }
			#custom-weylus {
				min-height: 0;
				padding: 2px 10px;
				border-radius: 8px;
				margin: 4px 4px;
				background-color: #${palette.base01};
				color: #${palette.base05};
			}
    '';
  };
}
