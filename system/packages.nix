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
    telegram-desktop
    whatsapp-for-linux
    syncthing
    syncthingtray
    libreoffice
    inkscape
		p3x-onenote
		notepad-next
  ];
}
