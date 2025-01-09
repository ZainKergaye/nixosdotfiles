{ pkgs, ... }: {
  users.users.aegis.extraGroups = [ "video" "disk" "dialout" "vboxusers" ]; # disk for rpi-imager
  # user group dialout for rw to serial ports
  # vbox users for vbox to usb devices

  environment.systemPackages = with pkgs; [
    # Dev packages
    astyle
    onefetch
    python3 # For calculator

    # General devtools
    git
    asciidoctor-with-extensions
    ccrypt
    unzip
    vlc
    mpv
    evince # PDF viewer
    nautilus # File manager
    loupe # Image viewer
    rpi-imager

    # System tools
    brightnessctl

    # User packages
    ungoogled-chromium
    syncthing
    syncthingtray
    libreoffice
    inkscape
    p3x-onenote
    notepad-next
    qbittorrent
    youtube-music
  ];
}
