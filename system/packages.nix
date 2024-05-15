{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    alejandra
    prettierd
    temurin-bin-20
    git
    asciidoctor-with-extensions

    ungoogled-chromium
    discord
    neofetch
    firefox
    bitwarden-desktop
  ];
}
