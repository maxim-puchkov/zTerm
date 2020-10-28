#!/bin/zsh

#  .zshrc 
#  /usr/local/zterm/zsh/.zshrc
#
#  User-specific profile for interactive zsh(1) shells.
#  Created on October 9, 2020.


#MARK: - Hashed Directories
hash -d zterm=$ZTERMDIR
hash -d zdot=$ZDOTDIR

hash -d lib=~zterm/Library
hash -d sources=~zdot/sources
hash -d functions=~zdot/functions
hash -d completions=~zdot/completions

hash -d etc=~zterm/etc
hash -d share=~zterm/share
hash -d var=~zterm/var
hash -d log=~var/log


hash -d home=~/private/home
hash -d dev=~/private/var/dev
hash -d text=~/private/var/test/text





#MARK: - Paths
# PATH
typeset -aU privatepath=(~/private/bin)
export -aUT PATH path=(
  $path
  ~zterm/bin
  $privatepath
  #$M2
)


# FPATH
export -aUT FPATH fpath=(
  $fpath
  ${(@f)"$(
    /usr/bin/find --     \
      $ZDOTDIR/functions \
      -type d            \
      2>/dev/null
  )"}
  $ZDOTDIR/completions
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


# Interactive history
export HISTFILE=$ZTERMDIR/var/log/History/$USER.zsh_history












#MARK: - Z-Shell
# Options
setopt extendedglob

# Modules
zmodload zsh/{zutil,zselect}

# Functions
autoload -Uz 'compinit' 'run-help' 'zargs'
autoload -Uz $ZDOTDIR/{functions,completions}/**/*~*.awk(.N)

# Oh-my-zsh directory
export ZSH=$ZDOTDIR/.oh-my-zsh
# Oh-my-zsh's plugins and themes
setarray -a plugins ~share/oh-my-zsh/plugins
setarray -a themes  ~share/oh-my-zsh/themes
if [[ ! -v ZSH_THEME ]]; then
  export ZSH_THEME=${themes[1]}
fi

# Source files
() {
  local file
  for file; do
    source $file
  done
} ~zdot/sources/*(N)

# Unalias oh-my-zsh aliases
unalias 'run-help' {1..9} '-' 'diff' 'md' 'rd'

# Unfunction oh-my-zsh's functions
unfunction d

# Initialize the completion system
compinit -d $ZTERMDIR/var/zcompdump

# Bindkey
bindkey '^X\x7f' backward-kill-line  # Command-Delete






#MARK: - Environment Variables
# Command line editor
export EDITOR=/usr/local/bin/nano


# grep
export GREP_COLOR='1;4;95'
## pcregrep, pcre2grep
export PCRE2GREP_COLOR="$GREP_COLOR"
## hgrep (highlightor grep)
export HGREP_COLOR='1;30;103'


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
setarray -A ZSH_HIGHLIGHT_STYLES --split-at ' ' ~share/zsh-highlight-styles


# add-color-functions
# Define functions for printing colored text.
() {
  local color_name
  local -a exclude=(default)
  for color_name in ${(k)fg:|exclude}; do
    function "$color_name"() {
      print -r -- "${fg[$0]}${argv}${fg[default]}"
      return "$# == 0"
    }
  done
}













#MARK: - Preexec
# zsh_update_preexec
#
# Update autoload functions that were modified
# while the terminal window is open.
function zsh_update_preexec() {
  # Last update file for current TTY.
  local last_update="/tmp/${TTY##*/}_update"
  if [[ ! -e $last_update ]]; then
    /usr/bin/touch $last_update
    return 0
  fi
  
  # Find all updated functions.
  local -a updated_files
  updated_files=(${(@f)"$(
    /usr/bin/find --       \
      $zsh_update_dirs     \
      -type f              \
      -mnewer $last_update \
      2>/dev/null
  )"})
  
  # Unset and re-autoload functions.
  local file name
  for file in ${updated_files[@]}; do
    name=${file:t}
    if [[ ${+functions[$name]} -eq 1 ]]; then
      unset -f -- $name
    fi
    autoload -Uz -- $name
  done
  
  # If functions were updated, touch last update.
  if [[ ${#updated_files} -gt 0 ]]; then
    /usr/bin/touch $last_update
    return 0
  fi
}


# Directories of files to auto-update
typeset -a zsh_update_dirs=($ZDOTDIR/functions)
preexec_functions+=(zsh_update_preexec)


# Announce the name of all executed commands.
function announce_preexec() {
  print
}










#MARK: - OTHER -

#TODO: - move
function watchfile() {
  typeset file=/usr/local/zterm/var/run/WatchFile
  if [[ ! -e $file ]]; then
    return 1
  fi
  /usr/bin/open -a Xcode -- "$file"
  /usr/local/bin/watch --color --differences --interval 2 -- "zsh $file"
}

#TODO: - move
function run_awk() {
  /usr/bin/awk "{ $argv }" ~text/awk.txt
}

#TODO: - move
function run_sed() {
  /usr/bin/sed -E -n -e "$argv" ~text/sed.txt
}





#TODO: - move
# printzf
#
# Print zformat.
#
# Usage:
# printzf formatstr [spec...]
#
# Examples:
# `printzf "The condition is %1(x.TRUE.FALSE)" x:2'
function printzf() {
  local -A opts
  zparseopts -D -E -A opts -
  local args
  zformat -f args "$argv"
  print -r -- "$args"
}

#TODO: - move
# man
#
# Colored man pages.
function man() {
  command env \
    LESS_TERMCAP_md=$'\e[96m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;7m'  \
    LESS_TERMCAP_us=$'\e[4;32m' \
    LESS_TERMCAP_ue=$'\e[0m'    \
      command $0 "$@"
}










# is
# Evaluate multiple conditional
# expressions at once.
#
# Usage:
# is condition[ ...] name
# function is() { ... }


#TODO: - move
# ifx
#
# Evaluate multiple expressions at once.
#
# Usage:
# ifx [ [ -op arg ] ... ]
#     [ [ arg1 -op arg2 ] ... ]
function ifx() {
  local -a expr
  local -i result
  
  # Group unary and binary conditions with arguments.
  while [[ "$1" =~ ^[-] && -n "$2" ]] ||
        [[ -n "$1" && "$2" =~ ^[-] && -n "$3" ]]; do
    # Make an expression
    unset expr result
    
    case "$1" in
      # Unary: [[ -n "$var" ]]
      -*) expr=($1 $2)
          shift 2 ;;
      # Binary: [[ $x -gt $y ]]
      *)  expr=($1 $2 $3)
          shift 3 ;;
    esac
    # Evaluate the expression
    eval "[[ $expr ]]"
    let result=$?
    # Print result (true/false)
    printzf "[[ $expr ]] is %0(r.$fg[green]true.$fg[red]false)$fg[default]" r:$result
  done
  
  # If there are more arguments, the expression was
  # incorrect or incomplete.
  if [[ $# -gt 0 ]]; then
    error -1 -m 'not an expression: ${argv}'
  fi
  
  return 0
}


#TODO: - move
function saytime() {
  builtin strftime '%R' |
  /usr/bin/say
}

#TODO: - move
function eval-every() {
  local -i interval=$1
  shift
  local -a cmd=($argv)
  while true; do
    println -IL --bg 11 -- $cmd
    $cmd
    printf '\n'
    sleep $interval
  done
}



# cpl Options
## -a, --alpha :: Alpha option -
#              -- cont -
#              -- continue 2.
## -b, --bravo :: Bravo option





# casex
#
# Options:
# -v <value> :: Set the value to be matched by patterns
# -p <pattern> :: Set the pattern to match values
#
# Usage:
# casex [-x <value>] pattern [pattern...]
function casex() {
  # Function options
  local -A opts
  local -a specs
  specs=('v:' 'p:')
  if [[ $# -gt 0 ]] &&
     {! zparseopts -D -K -M -A opts - $specs}; then
    return 1
  fi
  # Check option values
  if [[ ${+opts[-v]} -eq 0 ]] &&
     [[ ${+opts[-p]} -eq 0 ]]; then
    local alt1='"-v <value>"' alt2='"-p <pattern>"'
    error -1 -m 'either ${alt1} or ${alt2} must be specified'
  fi
  
  
  local -i color_t=2 color_f=1 color_p=4
  
  # Function arguments
  if [[ $# -eq 0 ]]; then
    error -1 -m 'not enough arguments'
  fi
  local value pattern
  case 1 in
    # -v <value>: set value for matching by patterns (arguments)
    ${+opts[-v]})
      value=${opts[-v]}
      for pattern; do
        case "$value" in
          (${~pattern}) print -P "Value '%F{$color_t}%U${value}%u%f' matches '%F{$color_p}%U${pattern}%u%f'" ;;
          (*) print -P -- "Value '%F{$color_f}%U${value}%u%f' does not match '%F{$color_p}%U${pattern}%u%f'" ;;
        esac
      done
    ;;
    # -p <pattern>: set pattern to match values (arguments)
    ${+opts[-p]})
      pattern=${opts[-p]}
      for value; do
        case "$value" in
          (${~pattern}) print -P "Value '%F{$color_t}%U${value}%u%f' matches '%F{$color_p}%U${pattern}%u%f'" ;;
          (*) print -P -- "Value '%F{$color_f}%U${value}%u%f' does not match '%F{$color_p}%U${pattern}%u%f'" ;;
        esac
      done
    ;;
  esac
  
  return 0
}






#TODO: - move
# expx
#
# Options:
# -f [flags] :: Set expansion flag :: ( '#' '##' '%' '%%' )
#
# Usage:
# `expx [ -f <flags> ] value
function expx() {
  # Function options
  local -A opts
  opts=([-f]='#')
  local -a specs
  specs=(${(k)^opts#-}':')
  if [[ $# -gt 0 ]] &&
     {! zparseopts -D -K -M -A opts - $specs}; then
    return 1
  fi
  local opts
  
  # Function arguments
  if [[ $# -lt 2 ]]; then
    error -1 -m 'not enough arguments'
  fi
  
  # Value to expand
  local value flags expansion result
  value=$1
  shift
  flags=${opts[-f]}
  
  for pattern; do
    # Expand value with current pattern
    expansion="\${\${:-${value}}${flags}${pattern}}"
    eval "result=${expansion}"
    # Print result of expansion
    printf '"%s%s%s" = "%s"\n' \
      "$(println -F1 $value)" "$(println -F3 $flags)" \
      "$(println -F4 -u $pattern)" "$(println -F2 $result)"
  done
  
  return 0
}











#TODO: - move
quote() {
  printf '%s\n' "${(qqqq)@}"
}

#TODO: - move
escape() {
  printf "\$'%s%s'\n" "\033\[" "${(j.;.)*}"
}
