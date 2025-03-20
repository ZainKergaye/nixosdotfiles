{ config
, pkgs
, ...
}: {
  # system management tool
  programs.dconf.enable = true;

  # User to be added to libvirtd group
  users.users.${config.variables.username}.extraGroups = [ "libvirtd" "vboxusers" ];

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

  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ]; # Patch for kernel 6.12 breaking vbox

  services.spice-vdagentd.enable = true;
}
