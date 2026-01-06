# Start configuration added by Zim Framework install {{{
export ZIM_PROMPT_THEME="starship" # Set default prompt theme

# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

# Guard against re-initialization when sourcing .zshrc
if [[ -z "$_ZIM_INITIALIZED" ]]; then
  export _ZIM_INITIALIZED=1

  ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
  # Download zimfw plugin manager if missing.
  if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
      curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
      mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
  fi
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
    source ${ZIM_HOME}/zimfw.zsh init
  fi
  # Initialize modules.
  source ${ZIM_HOME}/init.zsh
fi
# }}} End configuration added by Zim Framework install

# --------------------
# Custom yay aliases
# --------------------

# Install/Upgrade
alias yayi='yay -Syu'           # install, sync, and upgrade packages
alias yayu='yay -Syyu'          # install, sync, and upgrade (force refresh)
alias yayI='yay -S'             # install packages without syncing
alias yayU='yay -U'             # install packages by filename

# Remove
alias yayr='yay -R'             # remove package
alias yayrm='yay -Rns'          # remove package, dependencies, and configs

# Search
alias yays='yay -Ss'            # search remote repository
alias yayS='yay -Qs'            # search local repository

# Query
alias yayq='yay -Si'            # query package info from remote
alias yayQ='yay -Qi'            # query package info from local

# Orphans
alias yayol='yay -Qdt'          # list orphan packages
alias yayor='yay -Rns $(yay -Qtdq)'  # remove orphan packages

# Ownership
alias yayown='yay -Ql'          # list files belonging to package
alias yayblame='yay -Qo'        # show package owning file

# AUR specific
alias yayc='yay -Sc'            # clean package cache
alias yaycc='yay -Scc'          # clean all cache

# Interactive shell configurations
# (Environment variables are now in ~/.zshenv)

# direnv hook for directory-specific environments
eval "$(direnv hook zsh)"

# --------------------
# Dotfiles management
# --------------------

# Dotfiles management with bare git repo
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Helper aliases for common operations
alias config-status='config status'
alias config-diff='config diff'
alias config-log='config log --oneline --decorate --graph --all'
alias config-push='config push origin main'

# Function for AI-assisted commits with auto-backup
config-commit() {
    config add -u  # Stage all tracked changes
    config commit -m "$1"
    config push origin main
    echo "✓ Committed and pushed: $1"
}

# Quick rollback function
config-rollback() {
    config reset --hard HEAD~${1:-1}
    echo "✓ Rolled back ${1:-1} commit(s)"
}
