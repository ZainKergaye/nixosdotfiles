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

        credential."https://git.duranaero.com" = {
          username = "zain.kergaye";
          helper = "cache";

        };

        commit.gpgSign = true;
        tag.gpgSign = true;
        core.whitespace = "error"; # Throw error on whitespace
        push.autoSetupRemote = true;
        pull.rebase = true;
        diff.colorMoved = "zebra";
        fetch.prune = true;

        advice = {
          # All advice messages disabled
          addEmptyPathspec = false;
          pushNonFastForward = false;
          statusHints = false;
        };

        status = {
          branch = true; # Show branch
          showStash = true;
          short = true;
        };

        alias = {
          st = "stage";
          s = "status";
          a = "add";
          c = "commit";
          ph = "push";
          pl = "pull";
          f = "fetch";
        };
      };
    };
  };
}
