{ config, ... }: {
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    git = {
      enable = true;

      userName = config.variables.pretty_name;
      userEmail = config.variables.email;

      extraConfig = {
        core.whitespace = "error"; # Throw error on whitespace

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
