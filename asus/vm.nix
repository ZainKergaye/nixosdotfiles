{ pkgs, ... }:
{
  users.users.chonk.extraGroups = [
    "libvirtd"
    "vboxusers"
    "docker"
  ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.docker-compose ];
}
