{ lib, ... }:
with lib;
{
  options.variables = {
    username = mkOption {
      type = types.str;
      default = "khabib"; # Flake.nix is the only other instance of this
      description = "username";
    };

    hostname = mkOption {
      type = types.str;
      default = "nixos";
      description = "hostname";
    };

    initialHashedPassword = mkOption {
      type = types.str;
      default = "$y$j9T$lzgJEP2Hn9SNNts2xZqs11$CofLHlMHuKEfHVmRDrPNk0chYXIAWpWlRgBRzTEV6J4";
      description = "Initial Hashed Password";
    };

    sshPublicKey = mkOption {
      type = types.str;
      default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFTpmbNmbxtzoisG4RuEefCGGvxll13mqYsZQqd1z6e2 khabib@nixos";
      description = "SSH Public Key";
    };

    email = mkOption {
      type = types.str;
      default = "zain@zkergaye.me";
      description = "User email";
    };

    pretty_name = mkOption {
      type = types.str;
      default = "Zain Kergaye";
      description = "Full name";
    };

    editor = mkOption {
      type = types.str;
      default = "nvim";
      description = "Main editor";
    };

    default_browser = mkOption {
      type = types.str;
      default = "zen-browser";
      description = "Main browser";
    };
  };
}
