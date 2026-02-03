{
  config,
  pkgs,
  ...
}:
{
  # system management tool
  programs.dconf.enable = true;

  # User to be added to libvirtd group
  users.users.${config.variables.username}.extraGroups = [
    "libvirtd"
    "vboxusers"
  ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    virtiofsd
    spice
    spice-gtk
    spice-protocol
    virtio-win
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
        # TPM for windows
        swtpm.enable = true;
      };
    };

    spiceUSBRedirection.enable = true;

    virtualbox.host = {
      enable = true;
      #enableKvm = true;
    };

    vmVariant = {
      # following configuration is added only when building VM with build-vm
      virtualisation = {
        memorySize = 8192; # Use 8192MiB memory.
        cores = 3;
      };
    };
  };

  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ]; # Patch for kernel 6.12 breaking vbox

  services.spice-vdagentd.enable = true;
}
