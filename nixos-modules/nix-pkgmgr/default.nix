{ lib, ... }: {

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "quartus-prime-lite"
      "quartus-prime-lite-dark" # Look at quartus.nix
      "quartus-prime-lite-unwrapped"
      "zoom"
      "bambu-studio"
      "via"
    ];
}
