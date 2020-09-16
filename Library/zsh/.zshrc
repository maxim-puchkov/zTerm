#!/bin/zsh

#
#
#
#
#  User-specific profile for interactive zsh(1) shells.


#MARK: - Directories
# User home directories
export DEV="$HOME/Developer"
export PROJ="$HOME/Developer/Projects"
export iCloud="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Homebrew
export HOMEBREW='/usr/local/Homebrew'
export CELLAR='/usr/local/Cellar'

# zsh
export zdot="$ZDOTDIR"
export zterm="$ZTERM"
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














#MARK: - Command Environment Variables
# ls, du
export -i BLOCKSIZE=1024

# grep, pcregrep
export GREP_COLOR='1;95'
export PCREGREP_COLOUR="$GREP_COLOR"

# File editors
export EDITOR=$(<~zterm/etc/EDITOR)
export GUI_EDITOR=$(<~zterm/etc/GUI_EDITOR)

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# Xcode and Developer Tools
XCODE=${(M)$(xcode-select -p)#*'.app'}
export XCDOE








#MARK: - Paths
# Python path
export PYTHONSTARTUP=~/.pythonstartup
export -aT PYTHONPATH pythonpath
pythonpath=(
  ~/Library/ApplicationSupport/iTerm2/Scripts
  ~/Library/ApplicationSupport/iTerm2/iterm2env/**/python*/site-packages
  ~zterm/Python
#  /usr/local/lib/python3.7/site-packages/Cryptodome
)


# Command path
path=(
  /usr/local/opt/curl/bin
  /usr/local/sbin
  $path
  ~/Developer/bin
  /usr/local/opt/llvm/bin
  /usr/local/opt/python@3/bin
  /usr/local/opt/openssl@1.1/bin
)


# Function path
fpath=(
  /usr/local/opt/curl/share/zsh/site-functions
  /usr/local/share/zsh-completions
  $ZDOTDIR/functions
  $ZDOTDIR/completions
  $ZDOTDIR/custom
  $fpath
)










#MARK: - Miscellaneous
# Hide variables
typeset -H _ZSH_AUTOSUGGEST_BIND_COUNTS
typeset -H ZSH_HIGHLIGHT_STYLES
typeset -H ZSH_AUTOSUGGEST_ACCEPT_WIDGETS
typeset -H ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS
typeset -H ZSH_AUTOSUGGEST_IGNORE_WIDGETS
typeset -H ZSH_HIGHLIGHT_REVISION
typeset -H ZSH_AUTOSUGGEST_CLEAR_WIDGETS


#MARK: - Oh-my-zsh
# https://dev.to/manan30/what-is-the-best-zshrc-config-you-have-seen-14id
export ZSH="$ZDOTDIR/.oh-my-zsh"
if [[ ! -v ZSH_THEME ]]; then
  ZSH_THEME="${$(head -n1 ~zterm/etc/themes.oh-my-zsh):-robbyrussell}"
fi





#MARK: - Source Files
# Load modules
if ! zmodload -s zsh/{zutil,zprof,zselect}; then
  echo 'Unable to load zsh modules.' >&2
fi

# Oh-my-zsh
source "$ZSH/oh-my-zsh.sh"
# Z-Shell autosuggestions & syntax highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
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
autoload -Uz ~zdot/{site-functions,functions,completions}/*
