{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    zsh.shellAliases.g = lib.getExe' pkgs.git "git";
    git = {
      enable = true;

      settings = {
        user.name = config.variables.pretty_name;
        user.email = config.variables.email;

        signing = {
          format = "opengpg";
          signByDefault = true;
        };

        core.whitespace = "error"; # Throw error on whitespace

        push.autoSetupRemote = true;

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
