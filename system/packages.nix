{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    alejandra
    prettierd
    temurin-bin-20
    git
    asciidoctor-with-extensions

    brightnessctl

    ungoogled-chromium
    discord
    neofetch
    firefox
    telegram-desktop
    whatsapp-for-linux
    syncthing
    syncthingtray
    libreoffice
    inkscape

    rPackages.matlab
  ];
}
