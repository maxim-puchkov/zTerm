#!/bin/zsh

#  zsh-functions.zsh
#  ~zdot/zsh-functions.zsh
#
#  Zsh functions.
#  Created by mpuchkov/506:20 on March 29, 2021.



###  Shell Functions  ###

#MARK: - Command Execution
# FUNCTION
#   x, xtrace <command>
#
# DESCRIPTION
#   Run a command with enabled xtrace.
function x{,trace} {
  setopt xtrace
  "$@"
  unsetopt xtrace
}

# FUNCTION
#   ti [-n <number>] <commands>
function ti() {
  local -A opts=( -n 10 )
  zparseopts -D -F -K -A opts - n:
  print -P "Command: %F{3}${(z)argv}%f"
  print -P "Repeat: %F{3}$opts[-n]%f"
  eval "time ( ${(z)argv}
        repeat $(( $opts[-n] - 1 )); do
          ${(z)argv} &>/dev/null
        done ) &"
}




#MARK: - Set Values
# FUNCTION
#   statset <file>
#
# DESCRIPTION
#   Run command 'stat -s' on a file and store
#   the result in associative array 'stats'.
function statset() {
  local file=$1
  if [[ ! -r $file ]]; then
    error -1 -m 'cannot read file: ${file}.'
  fi
  typeset -g -A stats
  stats=( 'name' "${file:t}"  'file' "${file:P}"
    $(command stat -s $file | sed -E -e 's/st_([a-z]*)=([0-9]*)/\1 \2/g') )
}




#MARK: - Work Directory
export WD="$HOME/var/select/wd"

# setwd: set new work directory.
function setwd() {
  local new_wd="${*:a}"
  [[ $# -gt 0 ]]   || error 'not enough arguments'
  [[ -d $new_wd ]] || error 'not a directory: ${new_wd}'
  [[ -L $WD ]]     || error 'not a symbolic link: ${WD}'
  if [[ ${new_wd} -ef ${WD:P} ]]; then
    error 'work directory is already set to ${new_wd}'
  fi
  command unlink "$WD" &&
  command ln -s "$new_wd" "$WD"
  print-link $WD
}
# cwd: change directory to WD.
function cwd() {
  print -P -- "Changing directory to %U${WD:P}%u"
  cd -P $WD
}
# wwd: which WD?
function wwd() {
  print-link $WD
}










# print-link: print the target of a symbolic link.
function print-link() {
  typeset ARROW="%F{green}➜%f"
  if [[ $# -eq 0 ]]; then
    error -1 'usage: print-link <files>'
  fi
  local link target
  for link; do
    if [[ ! -e "$link" ]]; then
      error -0 '${link} does not exist' && continue
    fi
    if [[ ! -L "$link" ]]; then
      error -0 '${link} is not a symbolic link' && continue
    fi
    target="$(command readlink $link)"
    printf "%s %s %s\n" "${(D)link}" "${(%)ARROW}" "${(D)target}"
  done
}


#function zupdate() {
#  local file=$1
#  shift
#  local -a names=()
#  while [[ -n $1 ]]; do
#    if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc ) ]]; then
#      names+=($1)
#    fi
#    shift
#  done
#  if [[ -z $file ]] || [[ ${#names} -eq 0 ]]; then
#    return 2
#  fi
#  builtin zcompile $file $names
#}
























#MARK: - Misc. Functions
# Generate bundle identifier com.organization.
function bundle-id() {
  local org_id='com.maximpuchkov'
  local bundle_id="${org_id}.${*// /-}"
  if printf '%s' "$bundle_id" | command pbcopy; then
    printf "Bundle identifier '%s' was copied to clipboard\n" "$bundle_id"
  fi
}

# Run cmd in all shells
function shellsc() {
  local cmd="$*"
  local -a shells
  shells=($(grep -e '^/' </etc/shells))
  local s
  for s in $shells; do
    echo s is: $s
  done
}


