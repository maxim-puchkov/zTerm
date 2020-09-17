#!/bin/zsh

#
#
#
#
#  User-specific profile for interactive zsh(1) shells.


## (cd /usr/local/lib && sudo curl -O https://www.antlr.org/download/antlr-4.8-complete.jar )
#export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"
#alias antlr4='java -jar /usr/local/lib/antlr-4.8-complete.jar'
#alias grun='java org.antlr.v4.gui.TestRig'


# Key bindings
bindkey '^X\x7f' backward-kill-line  # Command-Delete

alias .g='open -a Xcode .gitignore'

#MARK: - Directories
# User home directories
export DEV="$HOME/Developer"
export PROJ="$HOME/Developer/Projects"
export iCloud="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
# Homebrew
export HOMEBREW='/usr/local/Homebrew'
export CELLAR='/usr/local/Cellar'
# Apache Maven
export M2_HOME='/usr/local/opt/apache-maven'
export M2="$M2_HOME/bin"
export MAVEN_OPTS="-Xms256m -Xmx512m"
# Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"
export zdot="$ZDOTDIR"
export zterm="$ZTERM"





#MARK: - Hashed Directories
# zsh
hash -d zterm="$ZTERM"
hash -d zdot="$ZDOTDIR"
hash -d zsh="$ZDOTDIR"
# Documents
hash -d dev=~/'Developer'
hash -d test=~/'Developer/Test'
hash -d docs=~/'Documents'
hash -d saved=~/'Documents/Saved Files'
# Library
hash -d scripts=~/'Library/Scripts'
# iCloud
hash -d iCloud=~/'Library/Mobile Documents/com~apple~CloudDocs'
hash -d Access=~iCloud/'Access'
# SFU
hash -d sfu=~iCloud/'SFU'
#
hash -d lb='/usr/local/bin'
hash -d t='/usr/local/Terminal'
hash -d zs=~zdot/'site-functions'
hash -d zf=~zdot/'functions'
hash -d zc=~zdot/'completions'
hash -d l=/usr/local





#MARK: - PATH
typeset -aUT PATH path=(
  /usr/local/opt/curl/bin
  /usr/local/sbin
  $path
  $M2
  /usr/local/opt/python@3/bin
  /usr/local/opt/openssl@1.1/bin
  /usr/local/opt/llvm/bin
  ~/Developer/bin
)


#MARK: - FPATH
typeset -aUT FPATH fpath=(
  /usr/local/opt/curl/share/zsh/site-functions
  /usr/local/share/zsh-completions
  $ZDOTDIR/functions
  $ZDOTDIR/completions
  $ZDOTDIR/custom
  $fpath
)
# Autoload zsh functions
autoload -Uz $ZDOTDIR/site-functions/*
autoload -Uz $ZDOTDIR/functions/*
autoload -Uz $ZDOTDIR/completions/*


# Python path
export -aUT PYTHONPATH pythonpath=(
#  ~/Library/ApplicationSupport/iTerm2/Scripts
#  ~/Library/ApplicationSupport/iTerm2/iterm2env/**/python*/site-packages
#  ~zterm/Python
#  /usr/local/lib/python3.7/site-packages/Cryptodome
)
export PYTHONENV=~/.pythonenv
export PYTHONSTARTUP=~/.pythonstartup









#MARK: - Command Environment Variables
# ls, du
export -i BLOCKSIZE=1024

# grep, pcregrep
export GREP_COLOR='1;95'
export PCREGREP_COLOUR="$GREP_COLOR"

# File editors
EDITOR=$(<~zterm/etc/EDITOR)
export EDITOR

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# Xcode and Developer Tools
XCODE=${(M)$(xcode-select --print-path)##*.app}
export XCODE


# Interactive history
if [[ -d $zterm/var/log ]]; then
  HISTFILE=$zterm/var/log/$USER.zsh_history
else
  HISTFILE=$HOME/.zsh_history
fi
export HISTFILE

# Oh-my-zsh theme
# https://dev.to/manan30/what-is-the-best-zshrc-config-you-have-seen-14id
if [[ ! -v ZSH_THEME ]]; then
  ZSH_THEME="${$(head -n1 ~zterm/etc/themes.oh-my-zsh):-robbyrussell}"
fi

# Oh-my-zsh plugins
typeset -a plugins
set -A plugins  ${(@f)"$(<~zterm/etc/plugins.oh-my-zsh)"}





#MARK: - Miscellaneous
# Hide variables
#typeset -H _ZSH_AUTOSUGGEST_BIND_COUNTS
#typeset -H ZSH_HIGHLIGHT_STYLES
#typeset -H ZSH_AUTOSUGGEST_ACCEPT_WIDGETS
#typeset -H ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS
#typeset -H ZSH_AUTOSUGGEST_IGNORE_WIDGETS
#typeset -H ZSH_HIGHLIGHT_REVISION
#typeset -H ZSH_AUTOSUGGEST_CLEAR_WIDGETS






#MARK: - Source Files
# Load modules
if ! zmodload -s zsh/{zutil,zprof,zselect}; then
  echo 'Unable to load zsh modules.' >&2
fi





# Oh-my-zsh
source "$ZSH/oh-my-zsh.sh"
# Z-Shell autosuggestions & syntax highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Z-Shell .z sources
source ~zdot/.zio
source ~zdot/.zalias
source ~zdot/.zutil
source ~zdot/.znetwork
source ~zdot/.zmisc
source ~zdot/.zcomp
source ~zdot/.ztest
# User functions
if [[ -f ~/private/zsh/functions/include.zsh ]]; then
  source ~/private/zsh/functions/include.zsh
fi
# iTerm 2
if [[ -f ~zdot/.iterm2/.iterm2_shell_integration.zsh ]]; then
  source ~zdot/.iterm2/.iterm2_shell_integration.zsh
fi





#MARK: - Autoload
unalias run-help
autoload -Uz run-help


## Shell startup files
#export ZPROFILE="$ZDOTDIR/.zprofile"
#export ZSHRC="$ZDOTDIR/.zshrc"
#export ZIO="$ZDOTDIR/.zio"
#export ZALIAS="$ZDOTDIR/.zalias"
#export ZEXPORT="$ZDOTDIR/.zexport"
#export ZUTIL="$ZDOTDIR/.zutil"
#export ZNET="$ZDOTDIR/.znetwork"
#export ZMISC="$ZDOTDIR/.zmisc"
#export ZCOMP="$ZDOTDIR/.zcomp"
#export ZTEST="$ZDOTDIR/.ztest"
## User zsh directories
#export zfunc="$zdot/functions"
#export zsitefunc="$zdot/site-functions"
#export zdisabled="$zdot/disabled"
#export zcomp="$zdot/completions"
#export ztest="$zdot/Tests"
#
## SFU
#export SFU="$iCloud/SFU"
#export SFU_USER='mpuchkov'
#export SFU_CSIL='csil-cpu4.cs.surrey.sfu.ca'
#export SFU_MNT="/usr/local/mnt/${SFU_USER}@${SFU_CSIL}"

#function hgrep() {
#  GREP_COLOR='1;30;103;' grep $@
  
#}


alias hgrep='GREP_COLOR="1;30;43" grep'
alias hegrep='GREP_COLOR="1;30;43" egrep'
alias hfgrep='GREP_COLOR="1;30;43" fgrep'
