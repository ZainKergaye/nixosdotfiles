{ ... }: {
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/srv/docker-backups" = {
    device = "10.0.0.83:/Docker";
    fsType = "nfs4";
  };
}
