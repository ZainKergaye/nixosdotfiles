# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    ../../asus

    ./hardware-configuration.nix
  ];

  networking.firewall = {
    enable = true;
  };

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        trusted-users = [ "@wheel" ];
        accept-flake-config = true;
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      #channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      package = pkgs.nixVersions.latest;
    };

  users.users = {
    khabib = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialHashedPassword = "${config.variables.initialHashedPassword}";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCilF7srnwC/e/SE8uANIRiVL2MszMneqiqCO4bBujLCq42rgC+9ZKCjMIkLTsGP8SK/1+UFnn5GF0FaMuLb/JV9RALAW7/LbtEHKfN8HL1kZ+KO2+ziiDIv3nbwXao9AEqhejuuCIYuhQ+J9IS8iO/C1cyqHKxJcABWgrB2tNn9L/2tYfGnYkHdJHzlKU+N/jeSf2jdAIilSmJEVoU9wLW9cKAOIA7a0RJ3c8WEdPgrGkjxame6GuIIU9PjjcfxXgjiIQ9VUzdkPlW520nSVK2B/mi2IHNcfv8zLyKrr+KhNzPbSMsnfquVmuivJoAvsBAqWoGtWN0JPD0+XnCkDK7Nvnxk2cMWtJp17l6iDxy/wAt2Qz88iEx4j4kEQh4x6GiBsfiMEtcW+OqogvuDVIzzPT9fbx8W+auyeOrKMS5TsrZfGvsDhJEOTh+ViBxogG0nDZkhSzveXsHeHhM4hsBp+3V8bIuXtf5+kc97NQg9EPxt3gU1Q/Y91afOh8geLU= root@localhost"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDwRYfuIL95bH2+N2CzSbe4ROQunjB5reG7ze3IfYOVDL/8V3xvYXw5+yJNb0YntaxFYavk5RmoWZ/pGWuIlMiFn65qhkSF8blBDZwAN8ano+9LEf200oZzFDaBz2AFtzCr1rTFgmFsgVjWc3LaRCw5VNCAn3vax1BM50/NkDJT8G71ynPw2nktYJTj+s5rSt0jmBQhApos/8s01RS53vOQ/EtCLSi1ivcp6Y+033ktZUD53RAl2eH3ZY7FZFxBFMEQ4ESN03GGYxwyGgzOKlYVvI8r6vWF4BO02s0/RYwg6fPPivLbwsr1uydLY7xFAauF/1rWvHoalNvokZn53+Ns3uvTUMvrEC5zU6CPaVt53g8/iDBqy61YSFnIIHic0qu9wDQ3ASQItnDbQCHQ5MN+kD1P3IuL5uaqZfXXZvxk82Dd+fCGKQkiKbVxg1cjkWFRC8b42CzBa26lU23+YVrdI8gEdX75vMyJF2nm2XYIeRYKe/MY45s48OgCSv5ND1M= zain@iMac"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLheOhnlJTCn1sIj7emj2sdrZjHffO5/2WlEzwOp5lm khabib@nixos"
      ];
      extraGroups = [
        "wheel"
        "sudo"
      ];
    };
    chonk = {
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCilF7srnwC/e/SE8uANIRiVL2MszMneqiqCO4bBujLCq42rgC+9ZKCjMIkLTsGP8SK/1+UFnn5GF0FaMuLb/JV9RALAW7/LbtEHKfN8HL1kZ+KO2+ziiDIv3nbwXao9AEqhejuuCIYuhQ+J9IS8iO/C1cyqHKxJcABWgrB2tNn9L/2tYfGnYkHdJHzlKU+N/jeSf2jdAIilSmJEVoU9wLW9cKAOIA7a0RJ3c8WEdPgrGkjxame6GuIIU9PjjcfxXgjiIQ9VUzdkPlW520nSVK2B/mi2IHNcfv8zLyKrr+KhNzPbSMsnfquVmuivJoAvsBAqWoGtWN0JPD0+XnCkDK7Nvnxk2cMWtJp17l6iDxy/wAt2Qz88iEx4j4kEQh4x6GiBsfiMEtcW+OqogvuDVIzzPT9fbx8W+auyeOrKMS5TsrZfGvsDhJEOTh+ViBxogG0nDZkhSzveXsHeHhM4hsBp+3V8bIuXtf5+kc97NQg9EPxt3gU1Q/Y91afOh8geLU= root@localhost"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDwRYfuIL95bH2+N2CzSbe4ROQunjB5reG7ze3IfYOVDL/8V3xvYXw5+yJNb0YntaxFYavk5RmoWZ/pGWuIlMiFn65qhkSF8blBDZwAN8ano+9LEf200oZzFDaBz2AFtzCr1rTFgmFsgVjWc3LaRCw5VNCAn3vax1BM50/NkDJT8G71ynPw2nktYJTj+s5rSt0jmBQhApos/8s01RS53vOQ/EtCLSi1ivcp6Y+033ktZUD53RAl2eH3ZY7FZFxBFMEQ4ESN03GGYxwyGgzOKlYVvI8r6vWF4BO02s0/RYwg6fPPivLbwsr1uydLY7xFAauF/1rWvHoalNvokZn53+Ns3uvTUMvrEC5zU6CPaVt53g8/iDBqy61YSFnIIHic0qu9wDQ3ASQItnDbQCHQ5MN+kD1P3IuL5uaqZfXXZvxk82Dd+fCGKQkiKbVxg1cjkWFRC8b42CzBa26lU23+YVrdI8gEdX75vMyJF2nm2XYIeRYKe/MY45s48OgCSv5ND1M= zain@iMac"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLheOhnlJTCn1sIj7emj2sdrZjHffO5/2WlEzwOp5lm khabib@nixos"
      ];
      extraGroups = [
        "wheel"
        "sudo"
      ];
    };
  };
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";

  programs.zsh = {
    enable = true;
    loginShellInit = "tmux attach";
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  time.timeZone = "America/Denver";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  # Prometheus
  networking.firewall.allowedTCPPorts = [ 9001 ];
  services.prometheus = {
    enable = true;
    port = 9001;

    exporters.node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
      port = 9002;
    };

    scrapeConfigs = [
      {
        job_name = "chonk";
        static_configs = [
          { targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ]; }
        ];
      }
    ];

  };
}
