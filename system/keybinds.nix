# Keybinding config imported into configuration.nix
{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.keyd
    pkgs.via
  ];

  services.udev.packages = [ pkgs.via ];

  hardware.keyboard.qmk.enable = true;

  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          #layer_indicator = "1";
          chord_timeout = "50"; #ms

          #"j + k + l" = "enter"; # Chording keys

          capslock = "overload(control, esc)";

          s = "overloadi(s, overloadt2(shift, s, 200), 150)";
          d = "overloadi(d, overloadt2(alt, d, 200), 150)";
          f = "overloadi(f, overloadt2(meta, f, 200), 150)";

          j = "overloadi(j, overloadt2(meta, j, 200), 150)";
          k = "overloadi(k, overloadt2(alt, k, 200), 150)";
          l = "overloadi(l, overloadt2(shift, l, 200), 150)";

          rightalt = "toggle(rightalt)";
        };

        rightalt = {
          s = "s";
          d = "d";
          f = "f";

          j = "j";
          k = "k";
          l = "l";
        };
      };
    };
  };
}
