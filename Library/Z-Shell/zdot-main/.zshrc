#!/bin/zsh

#  .zshrc 
#  /usr/local/zterm/zsh/.zshrc
#
#  User-specific profile for interactive zsh(1) shells.
#  Created on October 9, 2020.


# Ignore this file if 'RC' is set to 0.
if [[ -v RC ]] &&
   [[ "$RC" -eq 0 ]]; then
  print -Pf "Source file ignored: %s\n" \
         -- "%F{blue}%x%f"
  return 0
fi




#MARK: - Paths
# PATH
typeset -aU privatepath=(~/private/bin)
export -aUT PATH path=(
  $path
  $ZTERMDIR/bin
  $privatepath
  #$M2
)


# FPATH
export -aUT FPATH fpath=(
  $fpath
  $ZDOTDIR/{functions,completions}{,/**/*}(/N)
  /usr/local/share/zsh-completions
)


# PYTHONPATH
export -aUT PYTHONPATH pythonpath=(
  "$HOME/Library/Application Support/iTerm2/iterm2env/versions/3.8.0/lib/python3.8/site-packages"
  $pythonpath
)


# MANPATH
MANPATH="$(/usr/bin/man -W)"
export -aUT MANPATH manpath









#MARK: - Environment Variables
# Command line editor
export EDITOR=/usr/local/bin/nano

# grep, pcregrep, pcre2grep
export GREP_COLOR='1;4;95'
export PCRE2GREP_COLOR="$GREP_COLOR"

# ls
export LSCOLORS='Gxfxcxdxbxegedabagacad'

# du, ls
export -i BLOCKSIZE=1024

# less, man
export PAGER="less"
export LESS="-R"

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# History file
export HISTFILE="$ZTERMDIR/var/log/History/$LOGNAME.zsh_history"









#MARK: - Z-Shell
# Options
setopt extendedglob

# Modules
zmodload zsh/{zutil,zselect}

# Functions
autoload -Uz 'compinit' 'run-help' 'zargs'
autoload -Uz $ZDOTDIR/{functions,completions}/**/*~*'.awk'(.N)
#autoload -Uz $ZDOTDIR/completions/*(.N)


# Bindkey
bindkey '^X\x7f' backward-kill-line  # Command-Delete




#MARK: Oh-My-Zsh
# Directory
export ZSH="$ZDOTDIR/.oh-my-zsh"
# Plugins and themes
setarray -a plugins $ZTERMDIR/share/oh-my-zsh/plugins
setarray -a themes  $ZTERMDIR/share/oh-my-zsh/themes
if [[ ! -v ZSH_THEME ]]; then
  export ZSH_THEME=${themes[1]}
fi




#MARK: Source Files
() {
  local file
  for file; do
    source $file
  done
} $ZDOTDIR/sources/*(N)

# Unalias oh-my-zsh aliases
unalias 'run-help' {1..9} '-' 'diff' 'md' 'rd'

# Unfunction oh-my-zsh's functions
unfunction d


# Initialize the completion system
typeset COMPDUMP="$ZTERMDIR/var/zcompdump"
compinit -d "$COMPDUMP"


# Update modified autoload functions
prex -q add zsh_update















# Hide zsh autosuggestions parameters
typeset -H ZSH_AUTOSUGGEST_ACCEPT_WIDGETS
typeset -H ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS
typeset -H ZSH_AUTOSUGGEST_CLEAR_WIDGETS
typeset -H ZSH_AUTOSUGGEST_IGNORE_WIDGETS
typeset -H _ZSH_AUTOSUGGEST_BIND_COUNTS


# Hide zsh highlighting parameters
typeset  -H ZSH_HIGHLIGHT_REVISION
typeset -aH ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -AH ZSH_HIGHLIGHT_STYLES

# Read zsh highlight styles from file
setarray -A ZSH_HIGHLIGHT_STYLES --split-at ' ' $ZTERMDIR/share/zsh-highlight-styles


# add-color-functions
# Define functions for printing colored text.
#() {
#  local color_name
#  local -a exclude=(default)
#  for color_name in ${(k)fg:|exclude}; do
#    function "$color_name"() {
#      print -r -- "${fg[$0]}${argv}${fg[default]}"
#      return "$# == 0"
#    }
#  done
#}
# use `spectrum -ef -F'





















alias -- a+='prex add zsh_announce'
alias -- a-='prex rm zsh_announce'
alias -- v+='prex add zsh_verbose'
alias -- v-='prex rm zsh_verbose'
alias -- t+='prex add zsh_trace'
alias -- t-='prex rm zsh_trace'
#
#prex add zsh_update
#prex add zsh_trace
#prex add zsh_verbose

# Add preexec functions.
#preexec_functions+=(zsh_update_preexec)
#preexec_functions+=(announce_preexec)


















#MARK: - Directory Aliases
hash -d zterm=$ZTERMDIR
hash -d zdot=$ZDOTDIR

hash -d sources=~zdot/sources
hash -d functions=~zdot/functions
hash -d completions=~zdot/completions

hash -d etc=~zterm/etc
hash -d share=~zterm/share
hash -d var=~zterm/var
hash -d log=~var/log

hash -d lib=~zterm/Library
hash -d omz=~lib/Z-Shell/oh-my-zsh

hash -d home=~/private/home
hash -d dev=~/private/var/dev
hash -d text=~/private/var/test/text

hash -d proj=~/Developer/Projects

hash -d lb=/usr/local/bin



#MARK: - Executable Aliases
hash tldr==tealdeer













#MARK: - OTHER -
function zterm() {
  zterm_grep $argv
}




#TODO: - move
function run_awk() {
  /usr/bin/awk "{ $argv }" ~text/awk.txt
}

#TODO: - move
function run_sed() {
  /usr/bin/sed -E -n -e "$argv" ~text/sed.txt
}


function il() {
  local -A opts=([-m]="*")
  local -a specs=(I)
  if {! zparseopts -D -F -K -M -A opts - $specs}; then
    return 1
  fi
  
  if [[ ${+opts[-I]} -eq 1 ]] &&
     [[ ! -t 0 || -p /dev/stdin ]]; then
    set -- $argv ${(@f)"$(<&0)"}
  fi
  local mark='*'
  print -nr -C1 -- ${mark}' '${^argv}
}













# is
# Evaluate multiple conditional
# expressions at once.
#
# Usage:
# is condition[ ...] name
# function is() { ... }




#TODO: - move
alias saytime='builtin strftime "%I:%M %p" | /usr/bin/say &!'


#TODO: - move
function eval-every() {
  local -i interval=$1
  shift
  local -a cmd=($argv)
  while true; do
    #println -IL --bg 11 -- $cmd
    $cmd
    #printf '\n'
    sleep $interval
  done
}

























#TODO: - move
quote() {
  printf '%s\n' "${(qqqq)@}"
}

#TODO: - move
escape() {
  printf "\$'%s%s'\n" "\033\[" "${(j.;.)*}"
}



function is-in() {
  # Check type of specified array.
  local name=$1
  if [[ ! ${(Pt)name} =~ 'array' ]]; then
    error -1 -m '${name} is not an array'
  fi
  shift
  
  local element
  for element; do
    if [[ ${${(P)name}[(I)$element]} -eq 0 ]]; then
      error -0 -m '${element} is not in ${name}'
    fi
  done
  
}
