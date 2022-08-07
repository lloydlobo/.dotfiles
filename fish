if status is-interactive
    # Commands to run in interactive sessions can go here

    # Starship - like ohmyzsh
	starship init fish | source

	# McFly cmd history
    mcfly init fish | source

    #  nvbn / thefuck
    # thefuck --alias | source 

    # zoxide is a smarter cd command, inspired by z and autojump.
    zoxide init fish | source

    # TMUX UTF8 support
    alias tmux='tmux -u'
    export LC_ALL=en_IN.UTF-8
    export LANG=en_IN.UTF-8
end
