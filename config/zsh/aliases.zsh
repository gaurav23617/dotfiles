#!/bin/sh
alias c='clear'
alias vi='vim'
alias vim='nvim'
alias lg='lazygit'
alias lzd='lazydocker'
alias ff='fastfetch'
# alias logs='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n"'

# Colorize grep output (good for log files)
alias grep='rg'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Create alias override commands using 'eza'
alias ls='eza --group-directories-first --icons=auto'
alias ll='ls -lh --git'
alias ll='ls -lh'
alias la='ll -a'
alias tree='ll --tree --level=2'

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;
esac
