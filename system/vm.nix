{pkgs, ...}: {
  # system management tool
  programs.dconf.enable = true;

  # User to be added to libvirtd group
  users.users.aegis.extraGroups = ["libvirtd"];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme # Needed for wayland compositer
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
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
