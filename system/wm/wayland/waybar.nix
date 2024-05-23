{...}: {
  programs.waybar = {
    enable = true;

    style = builtins.readFile(./waybar.css);

    settings = {
      "bar" = {
        output = ["eDP-1" "DP-2" "DP-3"];
        # mode = "dock";
        layer = "top";
        position = "top";
        height = 24;
        width = null;
        exclusive = true;
        passthrough = false;
        spacing = 4;
        margin = null;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        fixed-center = true;
        ipc = true;

        # Modules display
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = [
          #"idle_inhibitor"
          "network"
          #"cpu"
          "memory"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
        ];

        # Modules
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        idle_inhibitor = {
          format = "{icon}";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Mute";
          format-bluetooth = " {volume}% {format_source}";
          format-bluetooth-muted = " Mute";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          scroll-step = 5.0;
          on-click = "pavucontrol";
          smooth-scrolling-threshold = 1;
        };
        network = {
          format-wifi = " {essid}";
          format-ethernet = " {essid}";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "睊";
          tooltip = true;
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        cpu = {
          format = " {usage0}%/{usage1}%/{usage2}%/{usage3}%/{usage4}%/{usage5}%/{usage6}%/{usage7}%";
          on-click = "btop";
        };
        memory = {
          format = " {used:0.1f}G/{total:0.1f}G ";
          interval = 5;
          on-click = "btop";
        };
        backlight = {
          interval = 2;
          align = 0;
          rotate = 0;
          #"device": "amdgpu_bl0",
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
          ];
          on-click = "";
          on-click-middle = "";
          on-click-right = "";
          on-update = "";
          on-scroll-up = "brightnessctl s 5%+";
          on-scroll-down = "brightnessctl s 5%";
          smooth-scrolling-threshold = 1;
        };
        battery = {
          interval = 60;
          align = 0;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = "  {capacity}%";
          format-full = "{icon}  Full";
          # format-good = "";
          format-alt = "{icon} {time}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-time = "{H}h {M}min";
          tooltip = true;
        };
        clock = {
          interval = 60;
          align = 0;
          rotate = 0;
          tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          format = " {:%I:%M %p}";
          format-alt = " {:%a %b %d, %G}";
        };
        tray = {
          icon-size = 14;
          spacing = 6;
        };
      };
    };
  };
}
