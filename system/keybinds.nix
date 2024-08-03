# Keybinding config imported into configuration.nix
{pkgs, ...}: {

  environment.systemPackages = [
    pkgs.keyd
  ];

  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = ["*"];
      settings.main = {
        capslock = "overload(control, esc)";
      };
    };
  };
}
