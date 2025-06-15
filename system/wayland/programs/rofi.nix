{ config
, pkgs
, ...
}:
let
  palette = config.colorScheme.palette;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [ pkgs.rofi-emoji ];
    theme = "${config.xdg.configHome}/rofi/configone.rasi";
    modes = [
      "drun"
      "emoji"
    ];
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, E, exec, rofi -mode emoji -show emoji"
    "$mod, SPACE, exec, rofi -show drun"
  ];

  home.file.".config/rofi/configone.rasi" = {
    text = ''
               /*****----- Configuration -----*****/
        configuration {
        	modi:                       "drun";
            show-icons:                 true;
            display-drun:               " ";
        	drun-display-format:        "{name}";
        }

        /*****----- Global Properties -----*****/
        *{
            font:                        "JetBrains Mono Nerd Font 10";
            background:                  #${palette.base00};
            background-alt:              #${palette.base01};
      text:						   #${palette.base05};
            foreground:                  #${palette.base05};
            selected:                    #${palette.base02};
            active:                      #${palette.base06};
            urgent:                      #${palette.base0E};
      alternate-normal-background: #${palette.base00};
        }

        /*****----- Main Window -----*****/
        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  false;
            width:                       400px;
            x-offset:                    0px;
            y-offset:                    0px;

            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               12px;
            border-color:                @selected;
            background-color:            @background;
            cursor:                      "default";
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     0px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @selected;
            background-color:            transparent;
            children:                    [ "inputbar", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     15px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            @selected;
            text-color:                  @text;
            children:                    [ "prompt", "entry" ];
        }

        prompt {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
        }
        textbox-prompt-colon {
            enabled:                     true;
            expand:                      false;
            str:                         "::";
            background-color:            inherit;
            text-color:                  inherit;
        }
        entry {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
            cursor:                      text;
            placeholder:                 "Search...";
            placeholder-color:           inherit;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     1;
            lines:                       6;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;

            spacing:                     5px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            cursor:                      "default";
        }
        scrollbar {
            handle-width:                5px ;
            handle-color:                @selected;
            border-radius:               0px;
            background-color:            @background-alt;
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     8px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            #000000;
            text-color:                  @foreground;
            cursor:                      pointer;
        }
        element normal.normal {
            background-color:            @background;
            text-color:                  @foreground;
        }
        element selected.normal {
            background-color:            @background-alt;
            text-color:                  @foreground;
        }
        element-icon {
            background-color:            transparent;
            text-color:                  inherit;
            size:                        32px;
            cursor:                      inherit;
        }
        element-text {
            background-color:            transparent;
            text-color:                  inherit;
            highlight:                   inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.0;
        }

        /*****----- Message -----*****/
        error-message {
            padding:                     15px;
            border:                      2px solid;
            border-radius:               12px;
            border-color:                @selected;
            background-color:            @background;
            text-color:                  @text;
        }
        textbox {
            background-color:            @background;
            text-color:                  @text;
            vertical-align:              0.5;
            horizontal-align:            0.0;
            highlight:                   none;
        }
    '';
  };
}
