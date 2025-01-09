# Keybinding config imported into configuration.nix
{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.keyd
  ];

  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overload(control, esc)";
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
