# Used for managing battery life, imported into configuration.nix
{ ... }: {
  services.tlp = {
    enable = true;
    settings = {
      STOP_CHARGE_THRESH_BAT0 = 80; # Cap internal battery at 80%
    };
  };
}