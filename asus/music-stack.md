# ASUS music stack setup

The ASUS host runs these native NixOS services:

- Navidrome: music server and OpenSubsonic API on port `4533`
- Lidarr: library manager on port `8686`
- qBittorrent: download client and Web UI on port `8080`
- ListenBrainz daily-playlist plugin: personalized recommendation playlists
- BorgBackup: weekly backups to the NFS-mounted repository

Only acquire and share music that you are legally permitted to transfer.
Lidarr and qBittorrent do not provide content by themselves.

## Storage layout

```text
/srv/music/library               Final music library
/srv/music/downloads/incomplete  In-progress qBittorrent downloads
/srv/music/downloads/complete    Completed qBittorrent downloads
/var/lib/navidrome               Navidrome database and configuration
/var/lib/lidarr                  Lidarr database and configuration
/var/lib/qBittorrent             qBittorrent configuration and torrent state
```

Application state and the music library are backed up by Borg to
`/srv/docker-backups/music-borg`, which is stored on the existing NFS mount.
Incomplete downloads and Navidrome's cache are excluded.

## Deploy

From the dotfiles repository:

```bash
sudo nixos-rebuild switch --flake .#asus
```

Verify all three services:

```bash
systemctl status navidrome lidarr qbittorrent --no-pager
```

If one fails, inspect its complete log rather than only the abbreviated status:

```bash
journalctl -u navidrome -u lidarr -u qbittorrent -b --no-pager
```

## Configure Navidrome

1. Open `http://asus:4533` and create the initial administrator.
2. Open the administrator's **Plugins** page.
3. Enable `listenbrainz-daily-playlist`.
4. Give the plugin access to the desired users and music library, including
   write access so it can create playlists.
5. Configure the plugin with your ListenBrainz username and desired daily or
   weekly playlist sources.
6. Under **Personal settings**, enable ListenBrainz scrobbling and enter your
   ListenBrainz user token.

Navidrome scans `/srv/music/library` every five minutes. Its built-in download
button is enabled, sharing is disabled, and anonymous insights are disabled.

## Configure qBittorrent

1. Open `http://asus:8080`.
2. Find the temporary administrator password in the initial service log:

   ```bash
   journalctl -u qbittorrent -b --no-pager | grep -i password
   ```

3. Sign in as `admin`, then immediately set a permanent username and strong
   password under **Tools -> Options -> Web UI**.
4. Under **Tools -> Options -> Downloads**, configure:

   ```text
   Default Save Path: /srv/music/downloads/complete
   Keep incomplete torrents in: /srv/music/downloads/incomplete
   ```

5. Create a `lidarr` category. Leave its save path blank so it inherits the
   default completed-download folder.

The Web UI listens on the LAN. Do not port-forward port `8080` from the router.
TCP and UDP port `6881` are used for BitTorrent peer traffic.

## Configure Lidarr

1. Open `http://asus:8686` and enable authentication.
2. Under **Media Management**, add `/srv/music/library` as the root folder.
3. Enable track renaming and choose the naming scheme you prefer.
4. Under **Download Clients**, disable or remove the old SABnzbd entry, then add
   qBittorrent with:

   ```text
   Host: 127.0.0.1
   Port: 8080
   Category: lidarr
   Username: qBittorrent Web UI username
   Password: qBittorrent Web UI password
   ```

5. Disable any Usenet-only indexers and add a BitTorrent-capable indexer, either
   directly in Lidarr or through Prowlarr. Add only sources you are entitled to
   access.
6. Test the download client and indexers before enabling automatic searches.

Lidarr should import completed downloads from
`/srv/music/downloads/complete` into `/srv/music/library`. Enable **Use Hardlinks
instead of Copy** in Lidarr so imported files do not consume duplicate space
while qBittorrent is seeding. Both services share the `music` group, and the
setgid directories preserve that group on new files.

## Recommendations

Recommendations come from ListenBrainz listening history. Scrobble regularly
before judging the results; its profile improves as listening history grows.
The plugin imports daily and weekly playlists into Navidrome, but it can only
play tracks already present in the local library.

If local-library similarity becomes more important later, AudioMuse-AI can be
added as a second phase. It performs sonic analysis but needs more CPU, memory,
and operational maintenance than the initial stack.

## Backups

The `Music` Borg job runs Sundays at 04:00 and retains four weekly and six
monthly archives. It briefly stops the three music services so their SQLite
databases are captured consistently, and starts them again even if Borg fails.
Check it with:

```bash
systemctl status borgbackup-job-Music.timer --no-pager
sudo systemctl start borgbackup-job-Music.service
journalctl -u borgbackup-job-Music -n 100 --no-pager
```

The job explicitly requires `/srv/docker-backups`, preventing it from writing
to the local mountpoint when the NFS share is unavailable.
