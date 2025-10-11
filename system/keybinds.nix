# Keybinding config imported into configuration.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    keyd
    via
  ];

  services.udev.packages = with pkgs; [
    via
    qmk-udev-rules
  ];

  hardware.keyboard.qmk.enable = true;

  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";

          a = "overloadi(a, overloadt2(shift, a, 200), 150)";
          s = "overloadi(s, overloadt2(alt, s, 200), 150)";
          d = "overloadi(d, overloadt2(control, d, 200), 150)";
          f = "overloadi(f, overloadt2(meta, f, 200), 150)";

          j = "overloadi(j, overloadt2(meta, j, 200), 150)";
          k = "overloadi(k, overloadt2(control, k, 200), 150)";
          l = "overloadi(l, overloadt2(alt, l, 200), 150)";
          ";" = "overloadi(;, overloadt2(shift, ;, 200), 150)";

          rightalt = "toggle(rightalt)";
        };

        rightalt = {
          a = "a";
          s = "s";
          d = "d";
          f = "f";

          j = "j";
          k = "k";
          l = "l";
          ";" = ";";
        };
      };
    };
  };
}
