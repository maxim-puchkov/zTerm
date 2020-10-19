#!/bin/zsh

#  .zshrc 
#  /usr/local/zterm/zsh/.zshrc
#
#  User-specific profile for interactive zsh(1) shells.
#  Created on October 9, 2020.


#MARK: - Hashed Directories
hash -d zterm=$ZTERMDIR
hash -d zdot=$ZDOTDIR

hash -d sources=~zdot/sources
hash -d functions=~zdot/functions
hash -d completions=~zdot/completions
hash -d modules=~zdot/modules

hash -d etc=~zterm/etc
hash -d share=~zterm/share
hash -d var=~zterm/var
hash -d log=~var/log


hash -d home=~/private/home
hash -d dev=~/private/var/dev
hash -d text=~/private/var/test/text





# PATH
typeset -aU privatepath=( ~/private/bin )
export  -aUT PATH path=( $path ~zterm/bin $privatepath ) # $M2

# FPATH
export -aUT FPATH fpath=(
  $fpath
  ${(@f)"$(find -P -- $ZDOTDIR/functions -type d 2>/dev/null)"}
  $ZDOTDIR/completions
  /usr/local/share/zsh-completions
)

# PYTHONPATH
export -aUT PYTHONPATH pythonpath=(
  "$HOME/Library/Application Support/iTerm2/iterm2env/versions/3.8.0/lib/python3.8/site-packages"
  $pythonpath
)

# Oh-my-zsh directory
export ZSH=$ZDOTDIR/.oh-my-zsh

# Interactive history
export HISTFILE=$ZTERMDIR/var/log/History/$USER.zsh_history












#MARK: - Z-Shell
# Bindkey
bindkey '^X\x7f' backward-kill-line  # Command-Delete

# Modules
zmodload zsh/{zutil,zselect}

# Options
setopt extendedglob

# Functions
autoload -Uz $ZDOTDIR/{functions,completions}/**/*(.N)
autoload -Uz 'run-help' 'compinit'

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

# Unalias Oh-my-zsh's aliases
unalias 'run-help' {1..9} '-' 'diff'

# Initialize the completion system
compinit







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


# man
MANPATH="$(/usr/bin/man -W)"
export -aUT MANPATH manpath


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
setarray -A ZSH_HIGHLIGHT_STYLES --split-at ' ' ~share/zsh-highlight-styles


# Function 'watchfile'
typeset WATCHFILE=/usr/local/zterm/zsh/WatchFile








#MARK: - zsh_update_preexec
# Automatically update autoload functions that
# were modified while Terminal window is open.
function zsh_update_preexec() {
  # Create separate last update file for each TTY.
  local last_update="/tmp/${TTY##*/}_update"
  if [[ ! -e $last_update ]]; then
    touch $last_update
    return 0
  fi
  
  
  # Find updated functions.
  local -a updated_functions
  updated_functions=(${(@f)"$(
    find -L $zsh_update_dirs -type f \
         -mindepth 1 -mnewer $last_update
  )"})
  if [[ ${#updated_functions} -eq 0 ]]; then
    return 0
  fi
  
  
  # Unset and re-autoload functions.
  local updated
  for updated in $updated_functions; do
    unset -f -- ${updated:t} && autoload -Uz -- ${updated:t}
  done
  # If any function was updated, touch last update.
  if [[ $? -eq 0 ]]; then
    touch $last_update
  fi
}


# Directories of files to auto-update
typeset -a zsh_update_dirs=($ZDOTDIR/functions)
preexec_functions+=(zsh_update_preexec)













#MARK: - OTHER -

typeset okvar='OK_VAR'
typeset badvar='BAD_VAR'
typeset sfmt1='He said, ${okvar}'
typeset sfmt2='He said, "${okvar}". But they said, "${badvar}"'



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
  zformat -f args $argv
  print -r -- "$args"
}


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



# zalias
#
# Add and edit zsh aliases defined in ~zdot/sources/zalias.
#
# Usage:
# `zalias'                  -- ask to open 'zalias' file in Xcode.
# `zalias <name>'           -- print value for the specified alias.
# `zalias <name> <value>'   -- write new alias to 'zalias' file.
function zalias() {
  local name=$1
  case $# in
    (0)
      printf 'Open "%s" in Xcode? [yn]\n' "$ZDOTDIR/sources/zalias"
      if read -qs; then
        /usr/bin/open -a Xcode
      fi ;;
    
    (1)
      if [[ ${+aliases[$name]} -eq 1 ]]; then
        builtin alias -L $name
      else
        error -1 -m '${name} is not an alias'
      fi ;;
    
    (*)
      local insert_text
      local -a value=(${argv:2})
      if [[ ${+aliases[$name]} -eq 0 ]]; then
        insert_text="alias ${name}='${value}'"
        echo $insert_text
      else
        error -1 -m 'alias ${name} already exists'
      fi ;;
  esac
  return 0
}






# is
# Evaluate multiple conditional
# expressions at once.
#
# Usage:
# is condition[ ...] name




#MARK: - Parse `cpl'
# Options
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







# expx
# Usage:
# `expx [ -f <flags> ] value
function expx() {
  # Function options
  ## -f [flags] :: Set the expansion modifier flags :: ( '#' '##' '%' '%%' )
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














#???: cdefopt
function cdefopt() {
  local short long description completion
  printf 'Enter short option name: ';   read short
#  short=${short//}
  
  printf 'Enter long option name: ';    read long
  printf 'Enter option description: ';  read description
  printf 'Enter option completion: ';   read completion
  
cat <<EOF
#compdef <#name#>

#  _<#name#>
#  Z shell completion function

_arguments -C -s -S -A \"-*\" \
  '($short $long)'

EOF
  
  
  return 0
}
