{ config
, nix-colors
, ...
}: {
  imports = [
    ./user/shell
    ./user/programs/programs.nix
    ./system/wm/wayland/hyprland.nix
    ./variables.nix
    nix-colors.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = config.variables.username;
  home.homeDirectory = "/home/${config.variables.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # home.useGlobalPkgs = true;
  # home.useUserPackages = true;

  programs = {
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    alacritty.enable = true;

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    git = {
      enable = true;

      userName = config.variables.pretty_name;
      userEmail = config.variables.email;
    };
  };

  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;

  home.sessionVariables = {
    EDITOR = config.variables.editor;
  };

  programs.home-manager.enable = true;
}
