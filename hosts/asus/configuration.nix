# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example
    ../modules/nixos/default.nix

    ./prometheus.nix
    ./firewall.nix
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  config.nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  config.nix =
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

  config.users.users = {
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
  config.services.logind.lidSwitch = "ignore";
  config.services.logind.lidSwitchDocked = "ignore";
  config.services.logind.lidSwitchExternalPower = "ignore";

  config.programs.zsh = {
    enable = true;
    loginShellInit = "tmux attach";
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  config.services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  config.time.timeZone = "America/Denver";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  config.system.stateVersion = "23.05";
}
