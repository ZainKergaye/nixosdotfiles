{ pkgs, ... }: {
  # system management tool
  programs.dconf.enable = true;

  # User to be added to libvirtd group
  users.users.aegis.extraGroups = [ "libvirtd" "vboxusers" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    virtiofsd
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    adwaita-icon-theme # Needed for wayland compositer
    glib

    # For solidworks:
    #virtualboxKvm
  ];

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # TMP for windows
        swtpm.enable = true;
        # Secure boot
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;

    virtualbox = {
      host = {
        enable = true;
        #enableKvm = true;
      };
    };
  };
  services.spice-vdagentd.enable = true;
}
