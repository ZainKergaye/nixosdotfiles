{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # Dev packages
    alejandra
    prettierd
    vimPlugins.luasnip
    astyle
    google-java-format
		eclipses.eclipse-sdk
		onefetch
		bottles


    # General devtools
    git
    asciidoctor-with-extensions

    # System tools
    brightnessctl
    fprintd
		linuxKernel.packages.linux_zen.ddcci-driver

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
		mpv
		evince
		loupe
		gnome.nautilus 
		youtube-music
		vlc
		peaclock 
		rpi-imager
		tetrio-desktop
		nextcloud-client
		nmap 
		wireshark
  ];
}
