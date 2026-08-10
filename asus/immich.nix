{ config, lib, ... }:

{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = "/srv/immich-originals";
    openFirewall = true;
    settings.newVersionCheck.enabled = false;

    machine-learning.enable = true;

    environment = {
      IMMICH_LOG_LEVEL = "warn";
      TMPDIR = "/srv/immich/tmp";
    };

    machine-learning.environment = {
      MACHINE_LEARNING_CACHE_FOLDER = lib.mkForce "/srv/immich/ml-cache";
      XDG_CACHE_HOME = lib.mkForce "/srv/immich/ml-cache";
    };
  };

  services.redis.servers.immich.logLevel = "warning";

  hardware.graphics.enable = true;
  services.immich.accelerationDevices = null;
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.borgbackup.jobs."Immich" = {
    paths = config.services.immich.mediaLocation;
    repo = "/srv/borg";
    startAt = "Sat 04:00";
    compression = "zstd";
    encryption.mode = "none";
    prune.keep = {
      last = 2;
    };
  };

}
