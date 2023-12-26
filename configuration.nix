{ config, pkgs, ... }:
{
  # ------------------------------------------
  # Application Configs
  # ------------------------------------------
  
programs.hyprland = {
	enable = true;
	xwayland.enable = true;
};
programs.zsh = {
	enable = true;
	shellAliases = {
		nixedit = "sudo nvim /etc/nixos/configuration.nix";
		vim = "nvim";
		vi = "nvim";
		nixupdate = "sudo nixos-rebuild switch";
		hypredit = "nvim ~/.config/hypr/hyprland.conf";
	};
	ohMyZsh = {

		enable = true;
		plugins = ["git"];
		theme = "gozilla";
	};
};






xdg.portal.enable = true;
xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk ];
# --------------------------------
# Music Player Daemon 
# --------------------------------
services.mpd = {
 enable = true;
 extraConfig = ''
  audio_output {
   type "pipewire"
   name "AudioOutput0"
   }
 '';
};
sound.enable = true;

security.rtkit.enable = true;

services.pipewire = {
 enable = true;
 alsa.enable = true;
 alsa.support32Bit = true;
 pulse.enable = true;
 jack.enable = true;
};

# --------------------------------
# Fonts
# --------------------------------

fonts.packages = with pkgs; [
   nerdfonts
   font-awesome
   fira-code
   fira-code-symbols
   mplus-outline-fonts.githubRelease
   noto-fonts
   noto-fonts-emoji
   proggyfonts

];


# --------------------------------
# Bluetooth
# --------------------------------

hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;


# --------------------------------
# Security
# --------------------------------

security.pam.services.swaylock = {};









  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

# --------------------------------
# Bootloader.
# --------------------------------
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.zain = {
    isNormalUser = true;
    description = "zain";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
  # ------------------------------------------
  # System esentials
  # ------------------------------------------
   waybar # Top bar
   swww # Wallpaper 
   dunst#
   swaylock
   wl-clipboard
   wlogout
   cliphist # Clip board mngr
   libnotify # Notification Daemons
   rofi-wayland
   brightnessctl
   networkmanagerapplet
   efibootmgr
   grub2_efi
   blueman

  # ------------------------------------------
  # Dev tools
  # ------------------------------------------
   wget
   git

  # ------------------------------------------
  # Applications
  # ------------------------------------------
   neovim  
   kitty # Terminal
   ungoogled-chromium
   neofetch
   vifm # File Manager
   btop
   waypaper

   # neovimPlugins.vim-prettier

  

   (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
   })
   )
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

 # Real time clock fixes for dual booting
 time.hardwareClockInLocalTime = true;
}
