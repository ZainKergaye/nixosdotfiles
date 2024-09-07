{pkgs, ...}: {
  users.users.aegis.extraGroups = ["wireshark" "video" "disk"]; # disk for rpi-imager

  environment.systemPackages = with pkgs; [
    # Dev packages
    alejandra # File formatter
    prettierd # File formatter
    vimPlugins.luasnip
    astyle
    google-java-format
    onefetch
    bottles
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

    # Networking ish things
    nmap
    wireshark

    # System tools
    brightnessctl
    fprintd

    # User packages
    ungoogled-chromium
    webcord
    neofetch
    whatsapp-for-linux
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
