# Helpers for Home Manager's structured Lua generator.
{ lib }:
let
  inline = lib.generators.mkLuaInline;
  bindWith = options: keys: dispatcher: {
    _args = [
      keys
      (inline dispatcher)
      options
    ];
  };
in
rec {
  inherit inline bindWith;
  bind = bindWith { };
  bindRepeat = bindWith { repeating = true; };
  modBind = keys: bind (inline ''mod .. " + ${keys}"'');
  modBindRepeat = keys: bindRepeat (inline ''mod .. " + ${keys}"'');
  exec = command: "hl.dsp.exec_cmd(${builtins.toJSON command})";
}
