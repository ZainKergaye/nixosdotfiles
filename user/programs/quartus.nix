{ config
, pkgs
, lib
, ...
}:
let
  quartusDarkStylesheet = pkgs.fetchFromGitHub {
    owner = "sandervanthul";
    repo = "quartus-stylesheet-dark";
    rev = "87342034bb4ec1efedf6e2664ab98a4a396bda66";
    hash = "sha256-XQguSj0NbT5p3yxRnB/XYptw143c3eaVXv2lZixKVq0=";
  };

  quartus-dark = pkgs.stdenv.mkDerivation {
    pname = "quartus-prime-lite-dark";
    version = pkgs.quartus-prime-lite.version;

    nativeBuildInputs = [ pkgs.makeWrapper ];
    buildInputs = [ pkgs.quartus-prime-lite ];

    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.quartus-prime-lite}/quartus/bin/quartus \
        $out/bin/quartus \
        --add-flags "-stylesheet=${quartusDarkStylesheet}/quartus_stylesheet_dark.qss"
    '';
    meta = pkgs.quartus-prime-lite.meta;
  };
in
{
  # This is quartus with the dark stylesheet provided by sandervanthul
  home.packages = [
    quartus-dark
  ];

  home.sessionVariables = {
    LM_LICENSE_FILE = "/home/${config.variables.username}/.secrets/license.dat";
    NUM_PARALLEL_PROCESSORS = "4";
  };

  # NOTE: For those using this in their own configuration, look at programs.nix
  # in the same dir, you need to allow the unfree package if not already allowed
  # in your system
}
