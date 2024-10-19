{ pkgs
, config
, ...
}: {
  home.packages = with pkgs; [ fastfetch ];
  programs.fastfetch.enable = true;

  # Taken from https://github.com/JorgeAlMoLa/fastfetch-boxes-theme
  home.file."${config.xdg.configHome}/fastfetch/config.jsonc".text = ''

    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "display": {
         "separator": "› "
      },
      "modules": [
            "title",
            "separator",
            {
                "type": "custom",
                "format": "\u001b[36m╭──────────── \u001b[32mSoftware \u001b[36m────────────"
            },
            {
                "type": "os",
                "key": "│ OS",
                "keyColor": "cyan"
            },
            {
                "type": "kernel",
                "key": "│ Kernel",
                "keyColor": "cyan"
            },
            {
                "type": "packages",
                "key": "│ Packages",
                "keyColor": "cyan"
            },
            {
                "type": "shell",
                "key": "│ Shell",
                "keyColor": "cyan"
            },
            {
                "type": "de",
                "key": "│ DE",
                "keyColor": "cyan"
            },
            {
                "type": "terminal",
                "key": "│ Terminal",
                "keyColor": "cyan"
            },
            {
                "type": "localip",
                "key": "│ Local IP",
                "keyColor": "cyan"
            },
            {
                "type": "custom",
                "format": "\u001b[36m├──────────── \u001b[32mHardware \u001b[36m────────────"
            },
            {
                "type": "host",
                "key": "│ Host",
                "keyColor": "cyan"
            },
            {
                "type": "cpu",
                "key": "│ CPU",
                "keyColor": "cyan"
            },
            {
                "type": "gpu",
                "key": "│ GPU",
                "keyColor": "cyan"
            },
            {
                "type": "memory",
                "key": "│ Memory",
                "keyColor": "cyan"
            },
            {
                "type": "disk",
                "key": "│ Disk",
                "keyColor": "cyan"
            },
            {
                "type": "custom",
                "format": "\u001b[36m├───────────── \u001b[32mUptime \u001b[36m─────────────"
            },
            {
                "type": "uptime",
                "key": "│",
                "keyColor": "cyan"
            },
            {
                "type": "custom",
                "format": "\u001b[36m╰──────────────────────────────────"

            },
            "colors",
            {
                "type": "custom",
                "format": " "
            },
            {
                "type": "custom",
                "format": " "
            }
        ]
    }
  '';
}
