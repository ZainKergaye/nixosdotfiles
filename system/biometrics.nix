{ pkgs, ... }: {
  # fprintd-enroll
  # Fingerprint biometrics support for swaylock
  # sudo fprintd-enroll -f left-index-finger {{USER}}
  # fprintd-verify

  environment.systemPackages = with pkgs; [
    fprintd-tod
    libfprint-2-tod1-vfs0090
  ];

  services.fprintd = {
    enable = true;
    tod.enable = true; # ISSUE: Not working
    tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };
}
