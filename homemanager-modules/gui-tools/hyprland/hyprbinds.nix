{ lib, config, ... }:
let
  inherit (import ./lua.nix { inherit lib; })
    inline
    bind
    modBind
    modBindRepeat
    ;
  screenshotDir = "/home/${config.variables.username}/Pictures/Screenshots";
  workspaceBinds = builtins.concatLists (
    builtins.genList (
      x:
      let
        workspace = x + 1;
        key = builtins.toString (workspace - ((workspace / 10) * 10));
      in
      [
        (modBind key ''hl.dsp.focus({ workspace = "${toString workspace}" })'')
        (modBind "SHIFT + ${key}" ''hl.dsp.window.move({ workspace = "${toString workspace}" })'')
      ]
    ) 10
  );

in
{
  config = lib.mkIf config.hyprland-hm-config.enable {
    wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + mouse:273"
          (inline "hl.dsp.window.resize()")
          { drag = true; }
        ];
      }
      {
        _args = [
          "SUPER + mouse:272"
          (inline "hl.dsp.window.drag()")
          { drag = true; }
        ];
      }
      (bind "mouse:275" ''hl.dsp.focus({ workspace = "m-1" })'')
      (bind "mouse:276" ''hl.dsp.focus({ workspace = "m+1" })'')
      (modBindRepeat "ALT + H" "hl.dsp.window.resize({ x = -10, y = 0, relative = true })")
      (modBindRepeat "ALT + J" "hl.dsp.window.resize({ x = 0, y = 10, relative = true })")
      (modBindRepeat "ALT + K" "hl.dsp.window.resize({ x = 0, y = -10, relative = true })")
      (modBindRepeat "ALT + L" "hl.dsp.window.resize({ x = 10, y = 0, relative = true })")
      (modBind "H" ''hl.dsp.focus({ direction = "left" })'')
      (modBind "J" ''hl.dsp.focus({ direction = "down" })'')
      (modBind "K" ''hl.dsp.focus({ direction = "up" })'')
      (modBind "L" ''hl.dsp.focus({ direction = "right" })'')
      (modBind "W" ''hl.dsp.exec_cmd("chromium")'')
      (modBind "Q" ''hl.dsp.exec_cmd("kitty")'')
      (modBind "C" "hl.dsp.window.close()")
      (modBind "V" "hl.dsp.window.float()")
      (modBind "F" "hl.dsp.window.fullscreen()")
      (modBind "T" "hl.dsp.window.pin()")
      (modBind "CTRL + 1" ''hl.dsp.window.tag({ tag = "op100" })'')
      (modBind "CTRL + 2" ''hl.dsp.window.tag({ tag = "op80" })'')
      (modBind "CTRL + 3" ''hl.dsp.window.tag({ tag = "op60" })'')
      (modBind "CTRL + I" ''hl.dsp.workspace.toggle_special("magic")'')
      (modBind "CTRL + SHIFT + I" ''hl.dsp.window.move({ workspace = "special:magic" })'')
      (modBind "CTRL + O" ''hl.dsp.workspace.toggle_special("hidden")'')
      (modBind "CTRL + SHIFT + O" ''hl.dsp.window.move({ workspace = "special:hidden" })'')
      (modBind "CTRL + U" ''hl.dsp.workspace.toggle_special("magicone")'')
      (modBind "CTRL + SHIFT + U" ''hl.dsp.window.move({ workspace = "special:magicone" })'')
      (modBind "CTRL + P" ''hl.dsp.workspace.toggle_special("hiddenone")'')
      (modBind "CTRL + SHIFT + P" ''hl.dsp.window.move({ workspace = "special:hiddenone" })'')
      (bind "Print" ''hl.dsp.exec_cmd("hyprshot -m output -o ${screenshotDir}")'')
      (bind "CTRL + Print" ''hl.dsp.exec_cmd("hyprshot -m region -o ${screenshotDir}")'')
      (modBind "CTRL + SHIFT + M" "hl.dsp.exit()")

    ]
    ++ workspaceBinds;
  };
}
