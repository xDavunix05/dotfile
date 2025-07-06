# ============================
# Zsh options and autocompletion settings
# ============================

setopt autocd              # Change directory just by typing its name
setopt interactivecomments # Allow comments in interactive mode
setopt magicequalsubst     # Enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # Hide error message if there is no match for the pattern
setopt notify              # Report the status of background jobs immediately
setopt numericglobsort     # Sort filenames numerically when it makes sense
setopt promptsubst         # Enable command substitution in prompt

# Configure word characters
WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# Hide EOL sign ('%')
PROMPT_EOL_MARK=""

# ============================
# Key bindings (emacs-like key bindings)
# ============================

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

# ============================
# Enable completion features
# ============================

autoload -Uz compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*' max-errors 1                         # Limit errors to avoid prompts
zstyle ':completion:*' menu select                          # Automatically show menu on TAB
zstyle ':completion:*' auto-description 'specify: %d'       # Show descriptions for completions
zstyle ':completion:*' completer _expand _complete          # Use expand and complete
zstyle ':completion:*' format 'Completing %d'                # Display a helpful message during completion
zstyle ':completion:*' group-name ''                         # Prevent grouping
zstyle ':completion:*' list-colors ''                        # Use the LS_COLORS for completion
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s  # Prompt feedback
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'    # Match case insensitively
zstyle ':completion:*' rehash true                           # Rehash to get new completions
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s  # Display scroll prompt
zstyle ':completion:*' use-compctl false                     # Disable compctl (compatibility with newer features)
zstyle ':completion:*' verbose true                          # Enable verbose mode for completion
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd' # Kill completion with process info

# ============================
# History configuration
# ============================

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # Ignore duplicated commands in the history list
setopt hist_ignore_space      # Ignore commands that start with a space
setopt hist_verify            # Show command with history expansion to user before running it

# ============================
# Prompt configuration with fancy format
# ============================

#configure_prompt() {
#    case "$PROMPT_ALTERNATIVE" in
#        twoline)
#            PROMPT=$'%B%F{130}%n%F{34}@%F{130}%m%f%F{0}\n%f%(#.%B%F{red}#%b.%B%F{76}⟼%b)%F{reset} '
#            ;;
#        oneline|backtrack)
#            PROMPT=$'%B%F{130}%n%F{34}@%F{130}%m%b %F{245}%~ %(#.%F{red}#.%F{76}$)%F{reset} '
#            ;;
#        *)
#            PROMPT=$'%F{red}[%n@%m %~]%f %# '
#            ;;
#    esac
#}

configure_prompt() {
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PROMPT=$'%F{130}%n%F{34}@%F{130}%m%f%F{0}\n%f%(#.%F{red}#.%F{76}⟼)%F{reset} '
            ;;
        oneline|backtrack)
            PROMPT=$'%F{130}%n%F{34}@%F{130}%m %F{245}%~ %(#.%F{red}#.%F{76}$)%F{reset} '
            ;;
        *)
            PROMPT=$'%F{red}[%n@%m %~]%f %# '
            ;;
    esac
}

PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
configure_prompt

# ============================
# Autosuggestions configuration
# ============================

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# ============================
# Directory colors for ls command
# ============================

 if [ -x /usr/bin/dircolors ]; then
     eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
     export LS_COLORS="$LS_COLORS:ow=30;44:"
#     alias ls='ls --color=auto'
     alias grep='grep --color=auto'
     alias diff='diff --color=auto'
     alias ip='ip --color=auto'
     zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
 fi


# ============================
# Handy aliases
# ============================

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# ============================
# Enable command-not-found handler
# ============================

if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi


# ============================
# EXPORT
# ============================
export HISTSIZE=10
export SAVEHIST=15


