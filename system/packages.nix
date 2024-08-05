{pkgs, ...}: {
  users.users.aegis.extraGroups = ["wireshark" "video"];

  environment.systemPackages = with pkgs; [
    # Dev packages
    alejandra
    prettierd
    vimPlugins.luasnip
    astyle
    google-java-format
    onefetch
    bottles

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
    firefox
    whatsapp-for-linux
    syncthing
    syncthingtray
    libreoffice
    inkscape
    p3x-onenote
    notepad-next
    cava
    qbittorrent
    youtube-music
    peaclock
    tetrio-desktop
    nextcloud-client
	ani-cli
  ];
}
