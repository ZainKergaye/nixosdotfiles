{ pkgs
, config
, ...
}:
let
  palette = config.colorScheme.palette;
in
{
  programs.waybar.enable = true;

  home.file."${config.xdg.configHome}/waybar/style.css".text = ''
        * {
          min-height: 0;
          font-family: IBM Plex Mono;
          font-size: 16px;
          font-weight: 500;
        }

        window#waybar {
          transition-property: background-color;
          transition-duration: 0.5s;
          background-color: rgba(24, 24, 37, 0.6);
        }

        window#waybar.hidden {
          opacity: 0.5;
        }

        #workspaces {
          background-color: transparent;
        }

        #workspaces button {
          all: initial;
          min-width: 0;
          box-shadow: inset 0 -3px transparent;
          padding: 2px 10px;
          min-height: 0;
          margin: 4px 4px;
          border-radius: 8px;
          background-color: #181825;
          color: #${palette.base0D};
        }

        #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          color: #1e1e2e;
          background-color: #${palette.base0D};
        }

        #workspaces button.active {
          color: #1e1e2e;
          background-color: #${palette.base0E};
        }

        #workspaces button.urgent {
          background-color: #${palette.base08};
        }

        #network,
        #clock,
        #pulseaudio,
        #custom-logo,
        #custom-power,
        #custom-spotify,
        #cpu,
        #tray,
        #memory,
        #window {
          min-height: 0;
          padding: 2px 10px;
          border-radius: 8px;
          margin: 4px 4px;
          background-color: #${palette.base01};
    color: #${palette.base05};
        }

        #battery {
          min-height: 0;
          padding: 2px 10px;
          border-radius: 8px;
          margin: 4px 4px;
          background-color: #${palette.base01};
    color: #${palette.base05};
        }

        #battery.warning {
        	background-color: #${palette.base0A};
     	color: #${palette.base01};
        }

        #battery.critical {
        	background-color: #${palette.base08};
     	color: #${palette.base01};
        }

     #battery.charging {
     	background-color: #${palette.base0B};
     	color: #${palette.base01};
     }

     #battery.critical:not(.charging) {
        	background-color: #${palette.base08};
        color: #${palette.base01};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
     }

     #battery.plugged {
     	background-color: #${palette.base00};
     }

        #custom-sep {
          padding: 0px;
          color: #${palette.base04};
        }

        window#waybar.empty #window {
          background-color: transparent;
        }

        #cpu {
          color: #94e2d5;
        }

        #memory {
          color: #cba6f7;
        }

        #clock {
          color: #${palette.base07};
        }

        #clock.simpleclock {
          color: #${palette.base09};
        }

        #window {
          color: #${palette.base0B};
        }

        #pulseaudio {
          color: #${palette.base05};
        }

        #pulseaudio.muted {
          color: #${palette.base09};
        }

        #custom-logo {
          color: #89b4fa;
        }

        #custom-power {
          color: #${palette.base08};
          padding-right: 5px;
          font-size: 14px;
        }

        @keyframes blink {
          to {
            background-color: #${palette.base08};
            color: #181825;
          }
        }

        tooltip {
          border-radius: 8px;
        }

     #audio_idle_inhibitor {
    color: #${palette.base0A};
     }

  '';

  home.file."${config.xdg.configHome}/waybar/config.jsonc".text = ''
        {
          "layer": "top",

          "position": "top",

          "height": 33,

          "spacing": 2,

          "exclusive": true,

          "gtk-layer-shell": true,

          "passthrough": false,

          "fixed-center": true,

          "modules-left": ["custom/logo", "hyprland/workspaces", "hyprland/window"],

          "modules-center": ["custom/sep", "clock#simpleclock", "custom/sep"],

          "modules-right": [
            "pulseaudio",
            "network",
            "clock",
            "group/batteries",
            "tray",
            "custom/power",
          ],

          "tray": {
            "show-passive-items": true,
            "spacing": 10,
          },

          "clock#simpleclock": {
            "tooltip": false,
            "format": "   {:%I:%M %p}",
            "on-click": "${pkgs.kitty}/bin/kitty peaclock",
          },

          "clock": {
            "format": "   {:L%a %d %b}",
            "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
          },

          "cpu": {
            "format": "  {usage}%",
            "on-click": "btop",
            "tooltip": true,
            "interval": 1,
          },

          "memory": {
            "format": "  {used:0.2f}G",
          },

          "pulseaudio": {
            "format": "{icon}  {volume}%",
            "format-muted": "  Muted",
            "format-icons": {
              "headphone": " ",
              "hands-free": "󰂑",
              "headset": "󰂑",
              "phone": " ",
              "portable": " ",
              "car": " ",
              "default": [" ", " ", " "],
            },
            "on-click": "${pkgs.pwvucontrol}/bin/pwvucontrol",
          },

          "custom/logo": {
            "format": " ",
            "tooltip": false,
            "on-click": "chromium-browser --new-window 'https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages&query=+'",
            "on-click-middle": "kitty --hold fastfetch",
      "on-click-right": "chromium-browser --new-window 'https://utah.instructure.com/'",
          },

          "custom/sep": {
            "format": "|",
            "tooltip": false,
          },

          "custom/power": {
            "tooltip": false,
            "on-click": "wlogout -p layer-shell &",
            "format": "⏻ ",
          },

          "network": {
            "format-wifi": "   {essid}",
            "format-ethernet": " ",
            "format-linked": "{ifname} (No IP)  ",
            "format-disconnected": "󰌙 ",
            "tooltip": true,
            "tooltip-format": "{ifname} {ipaddr}/{cidr} Up: {bandwidthUpBits} Down: {bandwidthDownBits}",
          },

          "battery#one": {
            "bat": "BAT0",
            "interval": 60,
            "states": {
              "warning": 30,
              "critical": 15,
            },
            "format": "{capacity}%  {icon} ",
            "format-icons": ["", "", "", "", ""],
            "max-length": 25,
          },

          "battery#two": {
            "bat": "BAT1",
            "interval": 60,
            "states": {
              "warning": 30,
              "critical": 15,
            },
            "format":"{capacity}%  {icon} ",
            "format-icons": ["", "", "", "", ""],
            "max-length": 25,
          },

          "group/batteries": {
            "modules": ["battery#one", "battery#two"],
            "orientation": "horizontal",
          },

    "custom/audio_idle_inhibitor": {
    	"format": "{icon}",
    	"exec": "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit --dry-print-both-waybar",
    	"exec-if": "which sway-audio-idle-inhibit",
    	"return-type": "json",
    	"format-icons": {
    		"output": " ",
    		"input": " ",
    		"output-input": "   ",
    		"none": ""
    	}
    },
        }

  '';
}
