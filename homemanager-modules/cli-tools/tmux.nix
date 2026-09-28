{
  lib,
  config,
  pkgs,
  ...
}:
let
  nerdFontWindowName = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nerd-font-window-name";
    version = "unstable-2026-09-21";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "c4a8baf3dc35707aa568eb2a69e270fc16728b71";
      hash = "sha256-9bLwV3Z3RYFqqlwy6WpKbyYs52bw4IFtmynkp7Hmzlo=";
    };
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
  };
in
{
  options.tmux-conf = {
    enable = lib.options.mkEnableOption "Enable personal tmux config.";
    # Configured in the ./default.nix in same dir tree
  };

  config = lib.mkIf config.tmux-conf.enable {
    programs.tmux = {
      enable = true;

      # Install and source plugins from the Nix store instead of relying on
      # TPM's imperative, network-dependent installation step.
      sensibleOnTop = true;
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig = "set -g @resurrect-strategy-vim 'session'";
        }
        {
          plugin = continuum;
          extraConfig = "set -g @continuum-restore 'on'";
        }
        nerdFontWindowName
      ];

      escapeTime = 0;
      historyLimit = 50000;
      baseIndex = 1;
      mouse = true;
      focusEvents = true;
      aggressiveResize = true;
      terminal = "tmux-256color";
      prefix = "C-a";
      keyMode = "vi";

      extraConfig = ''
        # Advertise true-colour support to applications inside tmux.
        set -as terminal-features ',xterm-256color:RGB'

        # Reload config
        bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

        # Better pane splitting (and keep current path)
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        # Vim-style pane navigation
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Vim-style pane resizing
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        # Use the terminal's own foreground/background colors. Active items
        # are distinguished with attributes instead of a separate palette.
        set -g status-position top
        set -g status-style 'bg=default,fg=default'
        set -g status-left-length 20
        set -g status-right-length 50
        set -g status-left '#[bold] #S #[nobold]│ '
        set -g status-right '│ %H:%M │ %d-%b-%y '

        setw -g window-status-style 'bg=default,fg=default'
        setw -g window-status-current-style 'bg=default,fg=default,reverse,bold'
        setw -g window-status-format ' #I:#W '
        setw -g window-status-current-format ' #I:#W '

        set -g pane-border-style 'fg=default'
        set -g pane-active-border-style 'fg=default,bold'

        # Pane scrollbars show scrollback position (tmux 3.6+).
        set -g pane-scrollbars on
        set -g pane-scrollbars-position right

        set -g message-style 'bg=default,fg=default,reverse,bold'

        # Use tmux/terminal clipboard integration (OSC 52), without pbcopy or
        # an X11-only clipboard utility.
        set -g set-clipboard on
        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi y send -X copy-selection-and-cancel
      '';
    };
  };
}
