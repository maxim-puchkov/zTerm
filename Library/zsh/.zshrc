#!/bin/zsh

#  .zshrc
#  Z shell
#
#  User-specific profile for interactive zsh(1) shells.
#  Created on June 9, 2020


#MARK: - Hashed Directories
# Z Shell
hash -d zdot="$ZDOTDIR"

# Terminal scripts
hash -d Terminal="$ZTERMDIR"
hash -d zterm="$ZTERMDIR"


## iCloud Documents
hash -d iCloud="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
hash -d Access=~iCloud/Access
hash -d sfu=~iCloud/SFU

## Home
hash -d dev="$HOME/Developer"
hash -d docs="$HOME/Documents"


## Private
hash -d home=~/private/home
hash -d test=~/private/var/test
hash -d text=~test/text


###  hash -d aliases  ###
hash -d zsh="$ZDOTDIR"
hash -d zs=~zdot/site-functions
hash -d zf=~zdot/functions
hash -d zc=~zdot/completions

hash -d l=/usr/local
hash -d lb=/usr/local/bin
hash -d ll=/usr/local/lib

hash -d T=~Terminal
hash -d log=~Terminal/var/log
###








# Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"

# Apache Maven
export M2_HOME='/usr/local/opt/apache-maven'
export M2="$M2_HOME/bin"
export MAVEN_OPTS='-Xms256m -Xmx512m'

# Homebrew
typeset HOMEBREW='/usr/local/Homebrew'
typeset CELLAR='/usr/local/Cellar'

# Antlr 4
typeset ANTLR='/usr/local/lib/antlr-4.8-complete.jar'
typeset ANTLR_RUNTIME='/usr/local/lib/antlr-runtime-4.8.jar'



# Home directories
typeset DEV="$HOME/Developer"
typeset PROJ="$HOME/Developer/Projects"
typeset iCloud="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Terminal scripts
typeset zterm="$ZTERMDIR"
typeset zdot="$ZDOTDIR"










#MARK: - Paths
# Private path
typeset -aU privatepath=( ~/private/bin )

# Function private path
typeset -aU fprivatepath=( ~/private/zsh/functions )


# PATH: directories of executable commands
typeset -aUT PATH path=(
  $path    $M2    $ZTERMDIR/bin    $privatepath
)


# FPATH: directories of Z shell autoload
# functions and function completions
typeset -aUT FPATH fpath=(
  /usr/local/opt/curl/share/zsh/site-functions
  /usr/local/share/zsh-completions
  $ZDOTDIR/{{,site-}functions,completions}
  $fpath
  $fprivatepath
)


# PYTHONPATH: default Python module search paths.
export -aUT PYTHONPATH pythonpath=(
  "$HOME/Library/Application Support/iTerm2/iterm2env/versions/3.8.0/lib/python3.8/site-packages"
  $pythonpath
)


# CLASSPATH: directories of Java classes
export -aUT CLASSPATH classpath=(
  .    $ANTLR    $classpath
)
#MARK: -











#MARK: - Environment Variables
# Command line editor
export EDITOR=/usr/local/bin/nano


# ls, du
export -i BLOCKSIZE=1024


# grep
export GREP_COLOR='1;4;95'
## pcregrep, pcre2grep
export PCRE2GREP_COLOR="$GREP_COLOR"
## hgrep (highlighted grep)
export HGREP_COLOR='1;30;103'


# man
MANPATH="$(/usr/bin/man -W)"
export -aUT MANPATH manpath

# gpg
GPG_TTY=$(tty)
export GPG_TTY


# Interactive history
if [[ -d /usr/local/Terminal/var/log ]]; then
  HISTFILE="$ZTERMDIR/var/log/$USER.zsh_history"
else
  HISTFILE="$HOME/.zsh_history"
fi
export HISTFILE
#MARK: -






 














#MARK: - Z Shell
# Bindkey
bindkey '^X\x7f' backward-kill-line  # Command-Delete

# Options
setopt extendedglob

# Modules
zmodload -s zsh/{zutil,zprof,zselect}


# Autoload zsh functions
autoload -Uz -- $ZDOTDIR/*{functions,completions}/*
autoload -Uz -- $fprivatepath/*

autoload -U  -- compinit  run-help


# Initialize the completion system
compinit





# Oh-my-zsh
## Plugins
typeset -a plugins
set -A plugins  ${"${(@f)$(<~Terminal/etc/plugins.oh-my-zsh)}":#*'#'*}
## Themes
typeset -a themes
set -A themes   ${"${(@f)$(<~Terminal/etc/themes.oh-my-zsh)}":#*'#'*}
if [[ ! -v ZSH_THEME ]]; then
  ZSH_THEME="${themes[1]}"
fi
## Source oh-my-zsh
source $ZSH/oh-my-zsh.sh





# Zdot
source ~zdot/.zalias
source ~zdot/.zutil
source ~zdot/.zcomp

source ~zdot/.ziterm2
source ~zdot/.ztell


# iTerm 2 shell integration
if [[ -f ~zdot/.iterm2/.iterm2_shell_integration.zsh ]]; then
  source ~zdot/.iterm2/.iterm2_shell_integration.zsh
fi


# Private
if [[ -f ~/private/zsh/functions/include.zsh ]]; then
  source ~/private/zsh/functions/include.zsh
fi





# Autosuggestions
## Source zsh autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
## Hide autosuggest parameters
typeset -H ZSH_AUTOSUGGEST_ACCEPT_WIDGETS
typeset -H ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS
typeset -H ZSH_AUTOSUGGEST_CLEAR_WIDGETS
typeset -H ZSH_AUTOSUGGEST_IGNORE_WIDGETS
typeset -H _ZSH_AUTOSUGGEST_BIND_COUNTS





# Highlighting
## Source zsh syntax highlightning
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## Hide highlight parameters
typeset -H ZSH_HIGHLIGHT_REVISION
typeset -aH ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -AH ZSH_HIGHLIGHT_STYLES
## Read styles from file
ZSH_HIGHLIGHT_STYLES+=(
  ${="${(@f)$(<~Terminal/etc/zsh-highlight-styles)}":#*'#'*}
)









# zsh_update_preexec
typeset -a zsh_update_dirs zsh_update_zdotdir_exclude


# Directories of files to auto-update
zsh_update_dirs=( $ZDOTDIR/functions $fprivatepath )
# Files excluded from auto-update
zsh_update_zdotdir_exclude=( $ZDOTDIR/.{zshrc,zsh_history} )


# Automatically reload autoload functions that
# were modified while Terminal is open
function zsh_update_preexec() {
  # Create separate last-update file for each TTY
  typeset last_update="/tmp/${TTY##*/}_update"
  if [[ ! -e $last_update ]]; then
    touch -- $last_update
    return 0
  fi
  local found
  # Find functions
  {
    set -- ${(@f)"$(find -L $zsh_update_dirs \
      -maxdepth 1 -type f -mnewer $last_update)"}
    for found; do
      unset -f -- ${found:t}
      autoload -Uz -- ${found:t}
    done
    
    set -- ${(@f)"$(find -L $ZDOTDIR -name '.z*' \
      -maxdepth 1 -type f -mnewer $last_update)"}
    for found; do
      source $found
    done
  } 2>/dev/null
  
  if [[ $? -eq 0 ]]; then
    touch $last_update
    return 0
  else
    return 1
  fi
}
preexec_functions+=(zsh_update_preexec)






#MARK: - Extras
# Python configuration files (not linked from Terminal/etc/python)
#export PYTHONENV=~/.pythonenv
#export PYTHONSTARTUP=~/.pythonstartup
