{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "20x3";
      fade-in = 0.1;
      color = "#000000";

      font = "JetBrainsMono Nerd Font Mono";
      font-size = 15;

      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-radius = 40;
      indicator-idle-visible = true;
      indicator-y-position = 1000;
    };
  };
  programs.hyprlock.enable = true;
}
