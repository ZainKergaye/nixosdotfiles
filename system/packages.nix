{
  config,
  pkgs,
	lib,
  ...
}:
{
  users.users.${config.variables.username}.extraGroups = [
    "video"
    "dialout"
  ]; # disk for rpi-imager
  # user group dialout for rw to serial ports
  # vbox users for vbox to usb devices

  environment.systemPackages = with pkgs; [
    # Dev packages
    python3 # For calculator

    # General devtools
    git
    ccrypt
    unzip
    zip
    vlc
    mpv
    evince # PDF viewer
    nautilus # File manager
    loupe # Image viewer

    # System tools
    brightnessctl
    cachix
    gp-saml-gui
    screen
    file

    # User packages
    ungoogled-chromium
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "quartus-prime-lite"
      "quartus-prime-lite-dark" # Look at quartus.nix
      "quartus-prime-lite-unwrapped"
      "zoom"
    ];

  programs.kdeconnect = {
    enable = true;
  };
}
