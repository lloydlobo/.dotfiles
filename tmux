# Some tweaks to the status line
# set -g status-right "%H:%M"
# set -g window-status-current-style "underscore"

# If running inside tmux ($TMUX is set), then change the status line to red
%if #{TMUX}
set -g status-bg red
%endif

# Enable RGB colour if running in xterm(1)
set-option -sa terminal-overrides ",xterm*:Tc"

# Change the default $TERM to tmux-256color
set -g default-terminal "tmux-256color"

# No bells at all
set -g bell-action none

# Keep windows around after they exit
set -g remain-on-exit on

# # Change the prefix key to C-a
# set -g prefix C-a
# unbind C-b
# bind C-a send-prefix

# I personally use Ctrl + Space mainly because my Vim leader key is the Space key. To change my prefix to Ctrl + Space:
# https://dev.to/iggredible/useful-tmux-configuration-examples-k3g
unbind C-Space
set -g prefix C-Space
bind C-Space send-prefix

# Turn the mouse on, but without copy mode dragging
set -g mouse on
unbind -n MouseDrag1Pane
unbind -Tcopy-mode MouseDrag1Pane

# Increase history-limij
set-option -g history-limit 5000

# Some extra key bindings to select higher numbered windows
bind F1 selectw -t:10
bind F2 selectw -t:11
bind F3 selectw -t:12
bind F4 selectw -t:13
bind F5 selectw -t:14
bind F6 selectw -t:15
bind F7 selectw -t:16
bind F8 selectw -t:17
bind F9 selectw -t:18
bind F10 selectw -t:19
bind F11 selectw -t:20
bind F12 selectw -t:21

# A key to toggle between smallest and largest sizes if a window is visible in
# multiple places
bind F set -w window-size

# Keys to toggle monitoring activity in a window and the synchronize-panes option
bind m set monitor-activity
bind y set synchronize-panes\; display 'synchronize-panes #{?synchronize-panes,on,off}'
set -g renumber-windows on

# Create a single default session - because a session is created here, tmux
# should be started with "tmux attach" rather than "tmux new"
new -d -s0 -nirssi 'exec irssi'
set -t0:0 monitor-activity on
set -t0:0 aggressive-resize on
neww -d -ntodo 'exec emacs ~/TODO'
setw -t0:1 aggressive-resize on
neww -d -nmutt 'exec mutt'
setw -t0:2 aggressive-resize on
# neww -d
# neww -d
# neww -d

# Activity monitoring
setw -g monitor-activity on
set -g visual-activity on

# hjkl pane traversal
# bind -n M-h select-pane -L
# bind -n M-j select-pane -D
# bind -n M-k select-pane -U
# bind -n M-l select-pane -R

# new window
bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

# Keep current path for new windows
bind c new-window -c "#{pane_current_path}"

# Toggle last windows
bind Space last-window

# Toggle between current & previous session
bind-key C-Space switch-client -l

# reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# auto window rename
set-window-option -g automatic-rename
set-option -g set-titles on

# window indexes
set -g base-index 1
setw -g pane-base-index 1

# No delay for escape key press
set -sg escape-time 0

# color
# set -g default-terminal "screen-256color"

# THEME
set-option -g status-position bottom
set -g status-bg black
set -g status-fg white
set -g window-status-current-bg white
set -g window-status-current-fg black
set -g window-status-current-attr bold
set -g status-interval 60
set -g status-left-length 30
# set -g status-left ''
# set -g status-right '#[fg=green]#(whoami) #[fg=yellow]#S #[fg=white]#[bold]%H:%M'
set -g status-left '#[fg=orange](#S) #(whoami) '
set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'
setw -g window-status-current-format "#I:#W"
setw -g window-status-format "#I:#W"
# statusline theme
# source "$HOME/.tmux/statusline"

# Vi copy/paste mode
set-window-option -g mode-keys vi

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-pain-control'
set -g @plugin 'tmux-plugins/tmux-sessionist'
set -g @plugin 'tmux-plugins/tmux-logging'
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Automatic tpm installation  https://github.com/tmux-plugins/tpm/blob/master/docs/automatic_tpm_installation.md
if "test ! -d ~/.tmux/plugins/tpm" \
   "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
