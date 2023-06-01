# Created by Zap installer
#[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
#plug "zsh-users/zsh-autosuggestions"
#plug "zap-zsh/supercharge"
#plug "zsh-users/zsh-syntax-highlighting"
#
#plug "wintermi/zsh-starship"
#plug "wintermi/zsh-rust"
# plug 'zsh-users/zsh-history-substring-search'

# theme
#plug "zap-zsh/zap-prompt"

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

alias cp="cp -i" # confirm before overwrite.
alias df="df -h"; # human-readable sizes.
alias mv="mv -i"; # confirm before overwrite.
alias ns="netstat -tup --wide"; # show active program sockets.
alias hist="history | awk '{\$1=\"\"; print \$0}' | fzf --height 40% --reverse --tac | xsel -i -b" # open a filtered history using fzf and copy the selected command to the clipboard using xsel -i -b.
alias ls='exa --all -F -H --group-directories-first --git -1 --icons --color always' #alias ls='ls -a --color'
alias ll="ls -alF"
alias lzd='lazydocker'
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr' # Source: Command Line Cheat Sheets by Elijah Manor.
alias yeet='thefuck' # alias for dc that runs cd instead.  # eval `thefuck --alias dc='cd'`

path+=("$HOME/.cargo/bin")
export PATH

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export VISUAL=nvim
export EDITOR=nvim

# pnpm
export PNPM_HOME="/home/lloyd/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# region_start: deno
#
# Manually add the directory to your $HOME/.bashrc (or similar)
  export DENO_INSTALL="/home/lloyd/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
# Run '/home/lloyd/.deno/bin/deno --help' to get started
# region_end: deno

. "$HOME/.asdf/asdf.sh"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# ~/.tmux/plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

# FZF VIM OPENER @source https://edward-rees.com/terminal-tricks/
# `-m` multi-select with tab/shift-tab
function __fsel_files() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  eval fd --hidden | fzf -m "$!" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

function fzf-vim {
    selected=$(__fsel_files)
    if [[ -z "$selected" ]]; then
        zle redisplay
        return 0
    fi
    zle push-line # Clear buffer
    BUFFER="nvim $selected";
    zle accept-line
}
zle -N fzf-vim
bindkey "^v" fzf-vim

# FIXME: Create new buffer,as fzf is still running in bg when suspending session to background using <C-z>.
function fzf_preview_edit() {
  local file_list
  if command -v fd >/dev/null; then
    file_list=$(fd --hidden --no-ignore)
  else
    file_list=$(find ./ -type f -print)
  fi
#  local preview_cmd="bat --color=always {}"
#  if ! command -v bat >/dev/null; then preview_cmd="less -R {}" fi
  echo "$file_list" | fzf --preview='[ -d {} ] && less {} || bat --color=always {}' \
    --bind ctrl-p:preview-page-up,ctrl-n:preview-page-down,shift-up:preview-page-up,shift-down:preview-page-down \
    --preview-window=right,70% \
    --bind='enter:execute($EDITOR {})'
}

zle -N fzf_preview_edit
bindkey "^f" fzf_preview_edit

source /home/lloyd/.config/broot/launcher/bash/br

# It's worth noting that zsh has its own built-in correction mechanism called correct. You can enable it by adding the following line to your .zshrc file:
#
setopt correct
#
# With correct enabled, zsh will attempt to correct your command if it detects a spelling mistake or other error. You can also use the nocorrect command to disable correction for a specific command. For example:
#
# nocorrect dc
#
# This will prevent zsh from attempting to correct dc if it is mistyped.
