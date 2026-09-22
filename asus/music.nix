{ pkgs, ... }:

let
  musicRoot = "/srv/music";
  libraryDir = "${musicRoot}/library";
  downloadDir = "${musicRoot}/downloads";
in
{
  # Navidrome serves the library, Lidarr manages it, and qBittorrent is the
  # download client. Keep the downloads and library on one filesystem so
  # Lidarr can hardlink imports while qBittorrent continues seeding.
  users.groups.music = { };
  users.users = {
    khabib.extraGroups = [ "music" ];
    chonk.extraGroups = [ "music" ];
    navidrome.extraGroups = [ "music" ];
    lidarr.extraGroups = [ "music" ];
    qbittorrent.extraGroups = [ "music" ];
  };

  services.navidrome = {
    enable = true;
    openFirewall = true;
    plugins = [ pkgs.navidromePlugins.listenbrainz-daily-playlist ];
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = libraryDir;
      ScanSchedule = "@every 5m";
      EnableInsightsCollector = false;
      EnableSharing = false;
      EnableDownloads = true;
      AutoImportPlaylists = true;
      LyricsPriority = ".ttml,.elrc,.lrc,.srt,.txt,embedded";
    };
  };

  services.lidarr = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        port = 8686;
        bindaddress = "*";
      };
      log.analyticsEnabled = false;
    };
  };

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    webuiPort = 8080;
    torrentingPort = 6881;
    # Accept the upstream notice non-interactively. Runtime settings remain
    # writable through the Web UI instead of being replaced on every restart.
    extraArgs = [ "--confirm-legal-notice" ];
  };

  # The qBittorrent module opens its configured ports over TCP. Peer discovery
  # also uses UDP on the torrenting port.
  networking.firewall.allowedUDPPorts = [ 6881 ];

  # Useful for importing, tagging, inspecting, and repairing music before it
  # enters Navidrome. Acquisition still needs to respect the source's licence.
  environment.systemPackages = with pkgs; [
    beets
    flac
  ];

  # The setgid bit keeps files written by any stack component in the shared
  # group. Navidrome only reads the library; Lidarr owns imports and renames.
  systemd.tmpfiles.settings."99-music-stack" = {
    "${musicRoot}".d = {
      user = "lidarr";
      group = "music";
      mode = "2775";
    };
    "${libraryDir}".d = {
      user = "lidarr";
      group = "music";
      mode = "2775";
    };
    "${downloadDir}".d = {
      user = "qbittorrent";
      group = "music";
      mode = "2775";
    };
    "${downloadDir}/incomplete".d = {
      user = "qbittorrent";
      group = "music";
      mode = "2775";
    };
    "${downloadDir}/complete".d = {
      user = "qbittorrent";
      group = "music";
      mode = "2775";
    };
  };

  systemd.services = {
    navidrome.unitConfig.RequiresMountsFor = [ musicRoot ];
    lidarr.unitConfig.RequiresMountsFor = [ musicRoot ];
    qbittorrent.unitConfig.RequiresMountsFor = [ musicRoot ];
    borgbackup-job-Music.unitConfig.RequiresMountsFor = [ "/srv/docker-backups" ];
  };

  services.borgbackup.jobs."Music" = {
    paths = [
      musicRoot
      "/var/lib/lidarr"
      "/var/lib/navidrome"
      "/var/lib/qBittorrent"
    ];
    exclude = [
      "${downloadDir}/incomplete"
      "/var/lib/navidrome/cache"
    ];
    repo = "/srv/docker-backups/music-borg/";
    startAt = "Sun 04:00";
    compression = "zstd";
    encryption.mode = "none";
    # Quiesce SQLite databases for a consistent snapshot. postHook runs even
    # when Borg fails, so the services are brought back either way.
    preHook = ''
      systemctl stop navidrome.service lidarr.service qbittorrent.service
    '';
    postHook = ''
      systemctl start navidrome.service lidarr.service qbittorrent.service
    '';
    prune.keep = {
      weekly = 4;
      monthly = 6;
    };
  };
}
