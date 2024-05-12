{ pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.alejandra
    pkgs.prettierd
  ];
}
