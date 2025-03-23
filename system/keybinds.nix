# Keybinding config imported into configuration.nix
{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.keyd
  ];

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

          s = "overload(shift, s)";
          d = "overload(alt, d)";
          f = "overload(meta, f)";

          j = "overload(meta, j)";
          k = "overload(alt, k)";
          l = "overload(shift, l)";

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
  # Second layer for keyboard
  # RShift to rotate forward layers
  # Ralt to rotate back layers
  # uiojklnm,. = 1234567890

  # or
  # Second layer
  # jkl toggle
  # sdf toggle back
  #fj = {}
  #gh = ()
  #dk = []
  #u = ;
}
