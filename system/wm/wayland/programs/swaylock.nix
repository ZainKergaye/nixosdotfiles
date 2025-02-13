{ pkgs
, config
, ...
}:
let
  palette = config.colorScheme.palette;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "5x5";
      fade-in = 0.1;

      font = "JetBrainsMono Nerd Font Mono";
      font-size = 15;

      line-uses-inside = true;

      disable-caps-lock-text = true;

      indicator-caps-lock = true;

      indicator-radius = 50;

      indicator-idle-visible = true;

      indicator-y-position = 540;

      show-failed-attempts = true;

      ignore-empty-password = true;
      indicator-thickness = 10;

      ring-color = "#${palette.base0B}";
      key-hl-color = "#${palette.base00}";

      color = "#000000";
      line-color = "#${palette.base0B}";
      inside-color = "#${palette.base01}";
      inside-clear-color = 00000088;
      separator-color = 00000000;
      ring-ver-color = "#${palette.base04}#";
      inside-ver-color = 00000000;
      text-color = "#${palette.base05}";
      bs-hl-color = "#${palette.base0F}";
      ring-clear-color = "#${palette.base0F}";
    };
  };
}
