{ pkgs, ... }: {
  users.users.aegis.extraGroups = [ "video" "disk" "dialout" "vboxusers" ]; # disk for rpi-imager
  # user group dialout for rw to serial ports
  # vbox users for vbox to usb devices

  environment.systemPackages = with pkgs; [
    # Dev packages
    alejandra # File formatter
    prettierd # File formatter
    vimPlugins.luasnip
    astyle
    onefetch
    python3 # For calculator
    mars-mips # MIPS for CS3810

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
    fprintd
    openvpn

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
    tetrio-desktop
    nextcloud-client
    ani-cli
  ];
}
