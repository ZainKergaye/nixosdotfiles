#!/usr/bin/env bash
# Evaluate the Home Manager Lua output and validate it with the exact pinned
# Hyprland binary. This never activates a generation or touches a compositor.
set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../../../.." && pwd)
cd -- "$repo_root"

target='.#nixosConfigurations.thinkpad.config.home-manager.users.khabib'
lua_attr="$target.xdg.configFile.\"hypr/hyprland.lua\".source"
hypr_attr="$target.wayland.windowManager.hyprland.package"

nix build --no-link --no-write-lock-file "$lua_attr"
nix build --no-link --no-write-lock-file "$hypr_attr"
lua_config=$(nix eval --raw --no-write-lock-file "$lua_attr")
hyprland=$(nix eval --raw --no-write-lock-file "$hypr_attr")/bin/Hyprland
runtime_dir=$(mktemp -d)
trap 'rm -rf "$runtime_dir"' EXIT
chmod 700 "$runtime_dir"
XDG_RUNTIME_DIR="$runtime_dir" "$hyprland" --config "$lua_config" --verify-config
