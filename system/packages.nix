{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    alejandra
    prettierd
    ungoogled-chromium
    discord
    git
    neofetch
    firefox
  ];
}
