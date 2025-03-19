{ pkgs, ... }: {
  users.users.aegis.extraGroups = [ "video" "disk" "dialout" ]; # disk for rpi-imager
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

    # User packages
    ungoogled-chromium
  ];
}
