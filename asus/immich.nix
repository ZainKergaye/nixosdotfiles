{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = "/srv/immich";
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

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;

    extensions = ps: [ ps.postgis ];
    identMap = ''
      # ArbitraryMapName systemUser DBUser
         superuser_map      root      postgres
         superuser_map      postgres  postgres
         superuser_map      immich    postgres
         # Let other names login as themselves
         superuser_map      /^(.*)$   \1
    '';
  };

  systemd.targets.postgresql.unitConfig.RequiresMountsFor = [ "/srv/postgresql" ];

  services.redis.servers.immich.logLevel = "warning";

  hardware.graphics.enable = true;
  services.immich.accelerationDevices = null;
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.borgbackup.jobs."Immich" = {
    paths = config.services.immich.mediaLocation;
    repo = "/srv/docker-backups/immich-borg/";
    startAt = "Sat 04:00";
    compression = "zstd";
    encryption.mode = "none";
    prune.keep = {
      last = 4;
    };
  };

  systemd.tmpfiles.settings.immich = {
    "/srv/immich".d = {
      user = "immich";
      group = "immich";
      mode = "0700";
    };
    "/srv/immich/thumbs".d = {
      user = "immich";
      group = "immich";
      mode = "0700";
    };
    "/srv/immich/upload".d = {
      user = "immich";
      group = "immich";
      mode = "0700";
    };
    "/srv/immich/encoded-video".d = {
      user = "immich";
      group = "immich";
      mode = "0700";
    };
    "/srv/immich/profile".d = {
      user = "immich";
      group = "immich";
      mode = "0700";
    };
    "/srv/immich/backups".d = {
      user = "immich";
      group = "immich";
      mode = "0700";
    };
    "/srv/immich/library".d = {
      user = "immich";
      group = "immich";
      mode = "0700";
    };

    # Create marker files
    "/srv/immich/thumbs/.immich".f = {
      user = "immich";
      group = "immich";
      mode = "0644";
    };
    "/srv/immich/upload/.immich".f = {
      user = "immich";
      group = "immich";
      mode = "0644";
    };
    "/srv/immich/encoded-video/.immich".f = {
      user = "immich";
      group = "immich";
      mode = "0644";
    };
    "/srv/immich/profile/.immich".f = {
      user = "immich";
      group = "immich";
      mode = "0644";
    };
    "/srv/immich/backups/.immich".f = {
      user = "immich";
      group = "immich";
      mode = "0644";
    };
    "/srv/immich/library/.immich".f = {
      user = "immich";
      group = "immich";
      mode = "0644";
    };
  };

}
