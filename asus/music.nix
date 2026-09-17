{ pkgs, ... }:

let
  musicRoot = "/srv/music";
  libraryDir = "${musicRoot}/library";
  downloadDir = "${musicRoot}/downloads";
  stateDir = "${musicRoot}/.state";
in
{
  # Navidrome serves the library, Lidarr manages it, and SABnzbd is the
  # provider-neutral download client. Keep all three on one filesystem so
  # Lidarr can use atomic moves when it imports completed downloads.
  users.groups.music = { };
  users.users = {
    khabib.extraGroups = [ "music" ];
    chonk.extraGroups = [ "music" ];
    navidrome.extraGroups = [ "music" ];
    lidarr.extraGroups = [ "music" ];
    sabnzbd.extraGroups = [ "music" ];
  };

  services.navidrome = {
    enable = true;
    openFirewall = true;
    plugins = [ pkgs.navidromePlugins.listenbrainz-daily-playlist ];
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = libraryDir;
      DataFolder = "${stateDir}/navidrome";
      CacheFolder = "${stateDir}/navidrome/cache";
      ScanSchedule = "@every 5m";
      EnableInsightsCollector = false;
      EnableSharing = false;
      EnableDownloads = true;
      AutoImportPlaylists = true;
      LyricsPriority = ".ttml,.elrc,.lrc,.srt,.txt,embedded";
      Backup = {
        Path = "${stateDir}/navidrome/backups";
        Schedule = "0 3 * * *";
        Count = 7;
      };
    };
  };

  services.lidarr = {
    enable = true;
    openFirewall = true;
    dataDir = "${stateDir}/lidarr";
    settings = {
      server = {
        port = 8686;
        bindaddress = "*";
      };
      log.analyticsEnabled = false;
    };
  };

  services.sabnzbd = {
    enable = true;
    openFirewall = true;
    configFile = "${stateDir}/sabnzbd/sabnzbd.ini";
  };

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
      user = "sabnzbd";
      group = "music";
      mode = "2775";
    };
    "${downloadDir}/incomplete".d = {
      user = "sabnzbd";
      group = "music";
      mode = "2775";
    };
    "${downloadDir}/complete".d = {
      user = "sabnzbd";
      group = "music";
      mode = "2775";
    };
    "${stateDir}".d = {
      user = "root";
      group = "music";
      mode = "0750";
    };
    "${stateDir}/sabnzbd".d = {
      user = "sabnzbd";
      group = "sabnzbd";
      mode = "0700";
    };
  };

  systemd.services = {
    navidrome.unitConfig.RequiresMountsFor = [ musicRoot ];
    lidarr.unitConfig.RequiresMountsFor = [ musicRoot ];
    sabnzbd.unitConfig.RequiresMountsFor = [ musicRoot ];
    borgbackup-job-Music.unitConfig.RequiresMountsFor = [ "/srv/docker-backups" ];
  };

  services.borgbackup.jobs."Music" = {
    paths = musicRoot;
    exclude = [
      "${downloadDir}/incomplete"
      "${stateDir}/navidrome/cache"
    ];
    repo = "/srv/docker-backups/music-borg/";
    startAt = "Sun 04:00";
    compression = "zstd";
    encryption.mode = "none";
    prune.keep = {
      weekly = 4;
      monthly = 6;
    };
  };
}
