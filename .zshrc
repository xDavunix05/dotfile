#Auto Start Tmux
if command -v tmux >/dev/null 2>&1; then
  [ -z "$TMUX" ] && exec tmux
fi
################################
# Zsh options
################################
setopt autocd                   # cd by typing directory name
setopt nonomatch                # no error if no match
setopt notify                   # notify about background jobs immediately
setopt promptsubst             # allow command substitution in prompt
setopt numericglobsort         # sort filenames numerically if possible
setopt interactivecomments     # allow comments in interactive mode

################################
# Aliases
################################
#System
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias history="history 0"
alias fuck='sudo'
alias upd='sudo pacman -Syu'
alias tm='tmux'
alias jl='journalctl'
alias clr='clear'

#EDITOR
alias mp='mousepad'

#GIT
alias gs='git status'         # Show status
alias ga='git add'            # Stage files
alias gc='git commit -m'      # Commit with message
alias gp='git push'           # Push to remote
alias gpl='git pull'          # Pull from remote
alias gb='git branch'         # List branches
alias gco='git checkout'      # Switch branches
alias gl='git log --oneline'  # Compact log
alias gr='git remote' # Remote

#Documentation
alias exploitdb='cd /usr/share/exploitdb/'
alias pydb='cd /usr/share/doc/python/html/'

################################
# History config
################################
HISTSIZE=15
SAVEHIST=10
setopt hist_ignore_space       # ignore commands starting with space
setopt hist_ignore_dups        # ignore duplicate history entries
setopt hist_expire_dups_first  # expire duplicate history entries first
setopt hist_verify             # show command before execution for editing
################################
# Directory colors for ls
################################
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi
################################
# Completion setup
################################
#compinit -d ~/.cache/zcompdump
#zstyle ':completion:*' max-errors 2
#zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' cache-path ~/.cache/zcompdump
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' format '%F{magenta}>>> %F{green}%d%F{magenta} <<<%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-max 10000
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-prompt ''
autoload -Uz compinit && compinit
compinit -d ~/.cache/zcompdump/.zcompdump-${HOST}
################################
# Wordchars and prompt tweaks
################################
PROMPT_EOL_MARK=""              # hide EOL mark
WORDCHARS=${WORDCHARS//\/}      # remove '/' from word characters
################################
# Prompt config
################################
git_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  if [[ -z $branch ]]; then
    return
  fi

  if [[ $branch == "HEAD" ]]; then
    local commit_hash=$(git rev-parse --short HEAD 2>/dev/null)
    local detached="DETACHED:$(echo "$commit_hash" | tr '[:lower:]' '[:upper:]')"
    echo " %B%F{red}${detached} ⦿%f%b"
  else
    local branch_upper=$(echo "$branch" | tr '[:lower:]' '[:upper:]')
    echo " %B%F{cyan}${branch_upper} ⦿%f%b"
  fi
}

PROMPT="[%F{213}%1~%f]\$(git_branch) %B➤ %b"
# Automatically update $PYTHON based on virtualenv
precmd() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        export PYTHON="$VIRTUAL_ENV/bin/python"
    else
        unset PYTHON
    fi
}
################################
# Keybind
################################
bindkey -e
bindkey ' ' magic-space
bindkey '^U' backward-kill-line
bindkey '^[[3;5~' kill-word
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[Z' undo
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

################################
# History HISTFILES
################################
export HISTFILE=$HOME/.history/.zsh_history
export MARIADB_HISTFILE=$HOME/.history/.mariadb_history

################################
# Function
################################
print -P "%F{50}$(grep -oP '(?<=^NAME=\")[^\"]+' /etc/os-release)%f"
print -P "[%n@%m]"

function print_os_user_info() {
  print -P "%F{50}$(grep -oP '(?<=^NAME=\")[^\"]+' /etc/os-release)%f"
  print -P "[%n@%m]"
}

function clear() {
  command clear   # run the real clear
  print_os_user_info  # print your info again
}

status_info() {
  if sudo -n true 2>/dev/null; then
    echo '%{%F{red}%}(sudo)%{%f%} '
  else
    echo ''
  fi
}

