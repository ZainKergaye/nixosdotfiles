{
  config,
  pkgs,
  ...
}:
let
  quartusDarkStylesheet = pkgs.fetchFromGitHub {
    owner = "sandervanthul";
    repo = "quartus-stylesheet-dark";
    rev = "87342034bb4ec1efedf6e2664ab98a4a396bda66";
    hash = "sha256-XQguSj0NbT5p3yxRnB/XYptw143c3eaVXv2lZixKVq0=";
  };

  desktopItemDark = pkgs.makeDesktopItem {
    name = "quartus-prime-lite-dark";
    exec = "quartus -stylesheet=${quartusDarkStylesheet}/quartus_stylesheet_dark.qss";
    icon = "quartus";
    desktopName = "Quartus Dark";
    genericName = "Quartus Prime dark";
    categories = [ "Development" ];
  };

  quartus-dark-desktop-item = pkgs.stdenv.mkDerivation {
    name = "quartus-dark-desktop-item";

    buildCommand = ''
      mkdir -p $out/share/applications
      ln -s ${desktopItemDark}/share/applications/* $out/share/applications
    '';
  };
in
{
  # This is quartus with the dark stylesheet provided by sandervanthul
  home.packages = [
    pkgs.quartus-prime-lite
    quartus-dark-desktop-item
  ];

  home.sessionVariables = {
    LM_LICENSE_FILE = "/home/${config.variables.username}/.secrets/license.dat";
    NUM_PARALLEL_PROCESSORS = "4";
  };

  # NOTE: For those using this in their own configuration, look at programs.nix
  # in the same dir, you need to allow the unfree package if not already allowed
  # in your system
}
