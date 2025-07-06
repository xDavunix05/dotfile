################################
# Zsh options
################################

setopt autocd                   # cd by typing directory name
setopt nonomatch                # no error if no match
setopt notify                   # notify about background jobs immediately
setopt promptsubst             # allow command substitution in prompt
setopt numericglobsort         # sort filenames numerically if possible
setopt hist_ignore_space       # ignore commands starting with space
setopt hist_ignore_dups        # ignore duplicate history entries
setopt hist_expire_dups_first  # expire duplicate history entries first
setopt hist_verify             # show command before execution for editing
setopt interactivecomments     # allow comments in interactive mode

################################
# Aliases
################################

#System
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

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


################################
# History config
################################

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

################################
# Directory colors for ls
################################

if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:"
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

################################
# Completion setup
################################

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcompdump
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

autoload -Uz compinit
compinit -d ~/.cache/zcompdump
################################
# Wordchars and prompt tweaks
################################

PROMPT_EOL_MARK=""              # hide EOL mark
WORDCHARS=${WORDCHARS//\/}      # remove '/' from word characters

################################
# Prompt config
################################

configure_prompt() {
    case "$PROMPT_ALTERNATIVE" in
        oneline|backtrack)
            PROMPT=$'%F{130}%n%F{34}@%F{130}%m %F{245}%~ %(#.%F{red}#.%F{76}$)%F{reset} '
            ;;
        twoline)
            PROMPT=$'%F{130}%n%F{34}@%F{130}%m%f\n%(#.%F{red}#.%F{76}⟼)%F{reset} '
            ;;
        *)
            PROMPT=$'%F{red}[%n@%m %~]%f %# '
            ;;
    esac
}

PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
configure_prompt


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



################################
# Environment 
################################

#VA-API ENABLE
export LIBVA_DRIVER_NAME=nvidia

##NVIDIA PRIME
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only

#VULKAN APPS 

export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
export VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d


