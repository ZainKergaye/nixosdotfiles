{ config, pkgs, ... }:
{
  programs = {
    # TODO: Figure out sops nix or some secret manager
    git = {
      enable = true;

      settings = {
        user.name = config.variables.pretty_name;
        user.email = config.variables.email;

        signing = {
          key = config.variables.sshPublicKey;
          format = "opengpg";
          signByDefault = true;
        };

        core.whitespace = "error"; # Throw error on whitespace

        commit.gpgSign = true;
        tag.gpgSign = true;

        advice = {
          # All advice messages disabled
          addEmptyPathspec = false;
          pushNonFastForward = false;
          statusHints = false;
        };

        status = {
          branch = true; # Show branch
          showStash = true;
        };
      };
    };
  };
}
