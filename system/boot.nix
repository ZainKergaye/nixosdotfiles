{ lib, pkgs, ... }:
{
  services.getty = {
    helpLine = lib.mkForce "";
    greetingLine = lib.mkForce "";
  };

  boot = {
    # Plymouth
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth = {
      enable = true;
      theme = "hexagon_alt";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "hexagon_alt" ];
        })
      ];
    };

    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];

    # Boot Loader
    loader = {
      timeout = 2;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        editor = true;
      };
    };
  };

  services.acpid.enable = true;
}
