# Gaming declaritive configuration
{ config
, pkgs
, ...
}: {
  hardware.graphics = {
    # Basic hardware drivers
    enable = true;
    enable32Bit = true;
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  # This starts the game in an optimized compositor

  environment.systemPackages = with pkgs; [
    mangohud # System specs overlay
    protonup # Linux gaming compatability later
  ];

  programs.gamemode.enable = true; # Game optimizer

  environment.sessionVariables = {
    # Proton needs to be declared imperitively.
    # This is just something to do with steam
    # Run the command 'protonup' after updating system NOTE: Run this every once in awhile
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${config.variables.username}/.steam/root/compatibilitytools.d";
  };
}
