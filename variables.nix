{ lib, ... }:
with lib; {
  options.variables = {
    username = mkOption {
      type = types.str;
      default = "aegis"; # Flake.nix is the only other instance of this
      description = "username";
    };

    hostname = mkOption {
      type = types.str;
      default = "conduit";
      description = "hostname";
    };

    email = mkOption {
      type = types.str;
      default = "zain4utah@gmail.com";
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
