# Imported into home-manager
{ pkgs
, lib
, zen-browser
, ...
}: {
  imports = [
    ./cava.nix
    ./peaclock.nix
    ./nixvim/nixvim.nix
    ./fastfetch.nix
  ];

  home.packages = with pkgs; [
    zapzap
    vesktop
    prusa-slicer
    bitwarden-desktop
    zen-browser.packages."x86_64-linux".default

    osu-lazer-bin

    gimp
    siril
    rawtherapee

    quartus-prime-lite
	kicad
  ];

  # Quartus prime variables
  home.sessionVariables.LM_LICENSE_FILE = "/home/aegis/.dotfiles/secrets/LR-214324_License.dat";
  home.sessionVariables.NUM_PARALLEL_PROCESSORS = "8";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "osu-lazer-bin"
      "quartus-prime-lite-unwrapped"
      "quartus-prime-lite"
    ];
}
