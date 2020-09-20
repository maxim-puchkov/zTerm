#!/bin/zsh

#
#
#
#
#  User-specific profile for interactive zsh(1) shells.




#MARK: - Directories
# User home directories
typeset DEV="$HOME/Developer"
typeset PROJ="$HOME/Developer/Projects"
typeset iCloud="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Homebrew
typeset HOMEBREW='/usr/local/Homebrew'
typeset CELLAR='/usr/local/Cellar'

# Apache Maven
export M2_HOME='/usr/local/opt/apache-maven'
export M2="$M2_HOME/bin"
export MAVEN_OPTS="-Xms256m -Xmx512m"

# Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"
typeset zdot="$ZDOTDIR"
typeset zterm="$ZTERM"

setopt extendedglob

# Run a command for the specified number of seconds
function time-interval() {
  let duration="${1:=1}"
  let end="$SECONDS+$duration"
  shift
  
  while [[ $SECONDS -lt $end ]]; do
    : # run command for
    echo ${(z)=@}
    ${(z)=@}
  done
}

#MARK: - Hashed Directories
# zsh
hash -d zterm="$ZTERM"
hash -d zdot="$ZDOTDIR"
hash -d zsh="$ZDOTDIR"
# Documents
hash -d dev=~/'Developer'
hash -d docs=~/'Documents'
# iCloud
hash -d iCloud=~/'Library/Mobile Documents/com~apple~CloudDocs'
hash -d Access=~iCloud/'Access'
# SFU
hash -d sfu=~iCloud/'SFU'
#
hash -d zs=~zdot/'site-functions'
hash -d zf=~zdot/'functions'
hash -d zc=~zdot/'completions'

hash -d l='/usr/local'
hash -d lb='/usr/local/bin'
hash -d ll='/usr/lolca/lib'

hash -d t='/usr/local/Terminal'



alias clrscreen='printf "\e[r"'

#MARK: - PATH
typeset -aUT PATH path=(
  $path
  $M2
#  /usr/local/sbin
#  /usr/local/opt/{curl,python3,llvm,openssl}/bin
  ~/Developer/bin
)





#MARK: - FPATH
typeset -aUT FPATH fpath=(
  /usr/local/opt/curl/share/zsh/site-functions
  /usr/local/share/zsh-completions
  $ZDOTDIR/site-functions
  $ZDOTDIR/functions
  $ZDOTDIR/completions
  ~/private/zsh/functions
  $fpath
)

# Autoload zsh functions
autoload -Uz $ZDOTDIR/site-functions/*
autoload -Uz $ZDOTDIR/functions/*
autoload -Uz $ZDOTDIR/completions/*
autoload ~/private/zsh/functions/*





#MARK: - PYTHONPATH
# Python path
export -aUT PYTHONPATH pythonpath=(
#  ~/Library/ApplicationSupport/iTerm2/Scripts
#  ~/Library/ApplicationSupport/iTerm2/iterm2env/**/python*/site-packages
#  ~zterm/Python
#  /usr/local/lib/python3.7/site-packages/Cryptodome
)
export PYTHONENV=~/.pythonenv
export PYTHONSTARTUP=~/.pythonstartup















## (cd /usr/local/lib && sudo curl -O https://www.antlr.org/download/antlr-4.8-complete.jar )
export ANTLR='/usr/local/lib/antlr-4.8-complete.jar'
export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"
alias antlr='java -jar /usr/local/lib/antlr-4.8-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
#ANTLR="/usr/local/lib/antlr-runtime-4.8.jar"
#export CLASSPATH="$ANTLR:$CLASSPATH"









#MARK: - Command Environment Variables
# ls, du
export -i BLOCKSIZE=1024

# grep, pcregrep
export GREP_COLOR='1;4;31'
export PCREGREP_COLOUR="$GREP_COLOR"

# File editors
export EDITOR=/usr/local/bin/nano

# Interactive history
if [[ -d $zterm/var/log ]]; then
  HISTFILE=$zterm/var/log/$USER.zsh_history
else
  HISTFILE=$HOME/.zsh_history
fi
export HISTFILE

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# Xcode and Developer Tools
XCODE=${(M)$(xcode-select --print-path)##*.app}
export XCODE







# Oh-my-zsh themes and plugins
typeset -a plugins themes
set -A plugins  ${(@f)"$(<~zterm/etc/plugins.oh-my-zsh)"}
set -A themes   ${(@f)"$(<~zterm/etc/themes.oh-my-zsh)"}
if [[ ! -v ZSH_THEME ]]; then
  ZSH_THEME="${themes[1]}"
fi





# Load modules
if ! zmodload -s zsh/{zutil,zprof,zselect}; then
  echo 'Unable to load zsh modules.' >&2
fi






#MARK: - Source Files
# Oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

# Z shell autosuggestions & syntax highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Z shell .z sources
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



# Key bindings
bindkey '^X\x7f' backward-kill-line  # Command-Delete





#MARK: - Autoload
unalias run-help
autoload -Uz run-help





typeset -a zsh_update_dirs
zsh_update_dirs=($ZDOTDIR/functions ~/private/zsh/functions ~/var/funcs)

# Reload autoload functions if they
# were modified since last update
function zsh_update_preexec() {
  typeset last_update="/tmp/${TTY##*/}_update"
  if [[ ! -e $last_update ]]; then
    touch -- $last_update
    return 0
  fi
  # Find function by name and re-autoload it
  local name="${2%% *}"
  set -- ${(@f)"$(find -L $zsh_update_dirs \
      -name "$name" -maxdepth 1 \
      -mnewer $last_update)"}
  for found; do
    unset -f -- ${found:t}
    autoload -- ${found:t}
    touch -- $last_update
  done
  return 0
}
preexec_functions+=(zsh_update_preexec)




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
# https://dev.to/manan30/what-is-the-best-zshrc-config-you-have-seen-14id





#MARK: - Miscellaneous
# Hide variables
#typeset -H _ZSH_AUTOSUGGEST_BIND_COUNTS
#typeset -H ZSH_HIGHLIGHT_STYLES
#typeset -H ZSH_AUTOSUGGEST_ACCEPT_WIDGETS
#typeset -H ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS
#typeset -H ZSH_AUTOSUGGEST_IGNORE_WIDGETS
#typeset -H ZSH_HIGHLIGHT_REVISION
#typeset -H ZSH_AUTOSUGGEST_CLEAR_WIDGETS


#ZSH_HIGHLIGHT_STYLES=( [arg0]='fg=green' [assign]=none [back-dollar-quoted-argument]='fg=cyan' [back-double-quoted-argument]='fg=cyan' [back-quoted-argument]=none [back-quoted-argument-delimiter]='fg=magenta' [bracket-error]='fg=red,bold' [bracket-level-1]='fg=blue,bold' [bracket-level-2]='fg=green,bold' [bracket-level-3]='fg=magenta,bold' [bracket-level-4]='fg=yellow,bold' [bracket-level-5]='fg=cyan,bold' [command-substitution]=none [command-substitution-delimiter]='fg=magenta' [commandseparator]=none [comment]='fg=black,bold' [cursor]=standout [cursor-matchingbracket]=standout [default]=none [dollar-double-quoted-argument]='fg=cyan' [dollar-quoted-argument]='fg=yellow' [double-hyphen-option]=none [double-quoted-argument]='fg=yellow' [globbing]='fg=blue' [history-expansion]='fg=blue' [line]='' [named-fd]=none [path]=underline [path_pathseparator]='' [path_prefix_pathseparator]='' [precommand]='fg=green,underline' [process-substitution]=none [process-substitution-delimiter]='fg=magenta' [rc-quote]='fg=cyan' [redirection]=none [reserved-word]='fg=yellow' [root]=standout [single-hyphen-option]=none [single-quoted-argument]='fg=yellow' [suffix-alias]='fg=green,underline' [unknown-token]='fg=red,bold' )

#typeset -A ZSH_HIGHLIGHT_STYLES

# Override highlighter colors
#ZSH_HIGHLIGHT_STYLES=(
#  [arg0]='fg=green,underline'
#  [history-expansion]='fg=red'
#  [comment]='fg=green,standout'
#  [assign]='bold'
#  [redirection]='fg=079'
#  [reserved-word]='fg=039'
#  [globbing]='fg=039'
#)

#  [back-dollar-quoted-argument]='bg=red' [back-double-quoted-argument]='bg=red' [back-quoted-argument]='bg=red'
#  [single-hyphen-option]='fg=yellow' [double-hyphen-option]='fg=yellow' [named-fd]='bg=red'


#ZSH_HIGHLIGHT_STYLES[default]=none
#ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
#ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
#ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
#ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
#ZSH_HIGHLIGHT_STYLES[function]=fg=white,bold
#ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
#ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
#ZSH_HIGHLIGHT_STYLES[commandseparator]=none
#ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
#ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
#ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
#ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
#ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
#ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
#ZSH_HIGHLIGHT_STYLES[assign]=none

