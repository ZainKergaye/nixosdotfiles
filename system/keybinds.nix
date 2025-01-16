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
          layer_indicator = "1";
          chord_timeout = "100"; #ms

          capslock = "overload(control, esc)";
          "j + k + l" = "enter"; # Chording keys

          rightalt = "toggle(rightalt)";
        };

        rightalt = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
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
