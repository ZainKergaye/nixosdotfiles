# New NixOS config 

This is my new NixOS config for dev, and everything else. Using flakes and home-manager.

# Screenshots:

![Screenshot](./media/screenshot.png)


## Dev environments
To configure whatever environment, you can use this command: 
nix flake init --template github:the-nix-way/dev-templates#java

Look at the-nix-way/dev-templates

## To implement
[x] Hyprland
[x] Java dev environment
[x] Virtualization for windows (KVM?)
[ ] smile emoji picker
[ ] Idle lock screen stopper waybar icon
[x] Better waybar config
[ ] Animation for hidden windows, have them pop from top

## Bugs

- [x] Network manager not remembering networks
- [x] study monitor not configured
- [x] Waybar not configured properly for more than one monitor
- - [x] Different font 
- - [x] Dual Battery support
- [x] Rofi themes
- [x] Dolphin file manager themes
- [x] Floating window rules Hyprland
- - [x] notepad next
- - [ ] save file
- - [ ] open file
- - [x] .blueman-manager-wrapped
- [ ] Discord screen sharing 
- [ ] Fingerprint enabled login 
- [x] Hyprland hidden keybinds to add letter 'p' and 'u'
- [x] Hyprshot doesn't work on monitor with negative position
- [ ]  Nixvim 
- - [ ] <Leader> ra -> needs to rename current highlighted variable, doesn't work yet.
- - [x] Add HELP and LABEL to todo comment highlighting 
- [ ] See if an opened window class can stay there? Like opening steam and moving to another window
