# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History configuration
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
export HISTSIZE=3
export SAVEHIST=5

# Check window size after each command
shopt -s checkwinsize

# Prompt configuration
prompt_color='\[\033[0;32m\]'  # Default prompt color
info_color='\[\033[1;34m\]'    # Info color
prompt_symbol=㉿

if [ "$EUID" -eq 0 ]; then
    # For root user
    prompt_color='\[\033[;94m\]'
    info_color='\[\033[1;31m\]'
    prompt_symbol=💀
fi

# Set the prompt
case "$PROMPT_ALTERNATIVE" in
    twoline)
        PS1="$prompt_color┌$info_color\u$prompt_symbol\h$prompt_color-[\w]\n└─$info_color\$ "
        ;;
    oneline)
        PS1="$info_color\u@\h:$prompt_color\[\033[01m\]\w\[\033[00m\]\$ "
        ;;
    backtrack)
        PS1="$info_color\u@\h:$prompt_color\[\033[01;31m\]\w\[\033[00m\]\$ "
        ;;
    *)
        PS1="\u@\h:\w\$ "
        ;;
esac

unset prompt_color info_color prompt_symbol

# Enable color support for ls, grep, and other commands
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
fi

# Handy aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Enable bash completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Set PATH (if needed)
export PATH="$PATH:~/.local/bin"

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*|Eterm|gnome*|alacritty)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac
