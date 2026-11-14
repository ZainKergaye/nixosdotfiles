# Hyprland Lua configuration

The configuration remains authored as Home Manager Nix data in the existing
Hyprland, colors, keybindings, and program modules. Home Manager renders
`hyprland.lua` using `configType = "lua"`. `lua.nix` provides shared binding
helpers. Each program/script owns its startup command through
`hyprland-hm-config.startupCommands`, executed on `hyprland.start` only.

Validate without switching a Home Manager or NixOS generation:

```sh
bash homemanager-modules/gui-tools/hyprland/scripts/verify-lua-config.sh
```

The script builds the generated thinkpad Lua and the pinned Hyprland binary,
then runs `--verify-config` in a temporary runtime directory. It does not reload
or start a desktop session. Monitor hardware, interactive keybindings, and app
behavior still need a desktop smoke test when you choose to activate.

Both NixOS and Home Manager explicitly use the portal from the same Hyprland
flake, avoiding the incompatible nixpkgs portal override that broke auto-updates.
