{ pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.alejandra
  ];
}
