# Used for managing battery life, imported into configuration.nix
# More info here:
# https://linrunner.de/tlp/index.html
# Running the command `tlp-stat -p` gives more system stats
{ ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      # Valid options are:
      # powersave
      # performance
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";

      # Valid options are:
      #	performance
      # balance_performance
      # default
      # balance_power
      # power

      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      # Determines limits of power consumption on high CPU load
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 70;
      #
      # START_CHARGE_THRESH_BAT0 = 75;
      # STOP_CHARGE_THRESH_BAT0 = 80;
      #
      # START_CHARGE_THRESH_BAT1 = 75;
      # STOP_CHARGE_THRESH_BAT1 = 90;
    };
  };
}
