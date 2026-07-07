{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    escapeTime = 10;
    mouse = true;
    baseIndex = 1;
    shortcut = "Space";
    shell = "${pkgs.fish}/bin/fish";

    extraConfig = ''
      set-option -g allow-rename off
      set-option -g focus-events on
      set-option -g extended-keys on

      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=blue'
      setw -g mode-style 'fg=black bg=blue'
      set -g status-right-style 'fg=black bg=blue'
      set -g status-right ' %Y-%m-%d %H:%M %p '
      setw -g window-status-current-style 'fg=black bg=blue'
      setw -g window-status-current-format ' #I #W '
      set -g message-style 'fg=black bg=blue bold'

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

      bind C-h resize-pane -L 10
      bind C-l resize-pane -R 10
      bind C-k resize-pane -U 10
      bind C-j resize-pane -D 10

      bind Tab next-window
      bind BTab previous-window
      bind t new-window
    '';
  };
}
