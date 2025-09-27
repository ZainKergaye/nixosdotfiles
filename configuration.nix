{ config
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system
    ./variables.nix
  ];

  boot.kernelParams = [ "acpi_backlight=native" ]; # DEP: Fix this

  networking = {
    hostName = config.variables.hostname;

    networkmanager.enable = true;
    networkmanager.dns = "none";
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = [
      "10.0.0.229" # NOTE: I'm not sure how this should work on other networks too
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.variables.username} = {
    isNormalUser = true;
    description = "${config.variables.username}";
    initialHashedPassword = "${config.variables.initialHashedPassword}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      trusted-users = [ "${config.variables.username}" ];
      substituters = [
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-public-keys = [
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
    };
  };

  hardware.graphics = {
    enable = true;
    #   extraPackages = with pkgs; [
    #     intel-media-sdk
    #   ];
  };

  system.stateVersion = "23.11";
}
