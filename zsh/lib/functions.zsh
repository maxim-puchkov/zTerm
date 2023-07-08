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
#   Run a command with enabled xtrace option.
function x{,trace} {
  setopt xtrace
  "$@"
  unsetopt xtrace
}


# FUNCTION
#   ti [-n <number>] <commands>
function ti {
  local -A opts=( -n 10 )
  builtin zparseopts -D -F -K -A opts - n:
  print -P "Command: %F{3}${(z)argv}%f"
  print -P "Repeat: %F{3}${opts[-n]}%f"
  eval "time ( ${(z)argv}
        repeat $(( ${opts[-n]} - 1 )); do
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
  stats=(
    'name' "${file:t}"  'file' "${file:P}"
    $(command stat -s $file \
    | command sed -E -e 's/st_([a-z]*)=([0-9]*)/\1 \2/g')
  )
}





#MARK: - Work Directory
export WD="$HOME/var/select/wd"

# swdl: set new working directory.
function swdl() {
  local new_wd="${*:a}"
  [[ $# -gt 0 ]]   || error 'not enough arguments'
  [[ -d $new_wd ]] || error 'not a directory: ${new_wd}'
  [[ -L $WD ]]     || error 'not a symbolic link: ${WD}'
  if [[ ${new_wd} -ef ${WD:P} ]]; then
    error 'work directory is already set to ${new_wd}'
  fi
  command unlink "$WD" &&
  command ln -s "$new_wd" "$WD"
  print-link "$WD"
}

# cwdl: change directory to WD.
function cwdl() {
  print -P -- "Changing directory to %U${WD:P}%u"
  cd -P "$WD"
}

# pwdl: print which directory is linked to WD.
function pwdl() {
  print-link "$WD"
}

alias wdl='pwdl'








# print-link: print the target of a symbolic link.
function print-link() {
  typeset ARROW="%F{green}➜%f"
  if [[ $# -eq 0 ]]; then
    error -1 -u 'print-link <files>'
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







# Read specified line from file.
function read-line {
  command sed -n -e "/${2}/p" $1
}

# Get 
function volume {
  command osascript -s es -e 'output volume of (get volume settings)'
}


# Execute script line by line
function step-by-step {
  local file=$1
  local -i i=1
  local line
  while read line; do
    printf '%i> %s\n' $i "$line"
    eval "$line"
    let i="$i+1"
#    print -Pf "%b%s%b\n" "%3F" "${(%%)line}" "%f"
  done < $file
}














###  preexec hooks  ###

# To add a preexec hook function:
#   `add-zsh-hook preexec <function>`

# Announce typed command.
function announce {
  say "${1}" &!
}

# Briefly announce executed command.
function announce_short {
  say "${2[(w)1]:t}" &!
}















###  Other Functions  ###
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
  local -a shells=($(grep -e '^/' </etc/shells))
  local shell
  for shell in $shells; do
    print -P "%2F>%f $shell"
    $shell -c "$cmd"
    print -P "%1F>%f Code: $status\n"
  done
}


# MISC FUNCTION
#   args - print arguments and argument count.
function args {
  emulate -L zsh
  trap 'printf "%s [count: %i]\n" "${(j:, :)argv:-(no arguments)}" $#' EXIT
}







## File functions ##

# FUNCTION
#   files
# DESCRIPTION
#   Set array files to all matching files in the directory.
# EXAMPLES
#   All directories on Desktop:   `files --glob ND/ --dir ~/Desktop'
function files {
  emulate -L zsh
  autoload -Uz error
  local -A opts=( --dir "$PWD" --glob "" )
  local -a specs=( '-dir:' 'd:=-dir'  '-glob:' 'g:=-glob' )
  if ! zparseopts -D -F -K -M -A opts - ${specs[@]} \
       2> >(error -I -d: -f3-); then
    return 1
  fi
  typeset -g -a files=( "${opts[--dir]}"/**("${opts[--glob]}") )
  typeset -p 1 files
}

# pbfile - Paste the clipboard into a new file (arg1).
function pbfile {
  typeset file="${1:-Pasted-file.txt}"
  if [[ -e $file ]]; then 
    error 'File already exists: ${file}'
  fi
  command pbpaste > $file
  printf "File created: %s\n" "$file"
}

# sizeof - Print size of file in human readable form.
function sizeof {
  for f; do
    [[ -f $f ]] || error -1 'not a regular file: ${f}'
    command ls -lah $f | awk '{print $5}'
  done
}




















# NAME
#   file_header
#
# SYNOPSIS
#   file_header <file> [description]
#
# DESCRIPTION
#   Generate header comment for a file.
function file_header() {
  local file=$1
  if [[ ! -e $file ]]; then
    error -1 -m 'file does not exist: ${file}.'
  fi
  local file_path="$(print -D -- ${file:A})" file_description="${@:2}"
  local sfmt='Created by %Su/%u:%g on %SB.' tfmt='%B %d, %Y'
  local file_created_on="$(command stat -t $tfmt -f $sfmt $file)"
  command cat <<EOF
#  ${file:t}
#  ${(%)file_description}
#
#  ${file_created_on}
#  ${file_path}
EOF
}


function owner {
  command ls -la $@ |
  command awk '{
    printf $3""FS""$4""FS;
    for (i=9; i<=NF; i++) {
      printf $i,FS;
    }
    print "";
  }'
}

function dirsize {
  while [[ -n "$1" ]]; do
    command du -h -d0 "$1" | command awk '{print $1;}'
    shift
  done
}


# FUNCTION
#   termsize
#
# DESCRIPTION
#   Print number of terminal window's columns and rows.
function termsize {
  local -A opts
  if ! zparseopts -D -F -A opts - l \
       2> >(error -I -d: -f3-); then
    return 1
  fi
  local fstr="%ix%i\n"
  if [[ ${+opts[-l]} -eq 1 ]]; then
    fstr="columns: %i, rows: %i\n"  # Long output
  fi
  printf "$fstr" $COLUMNS $LINES
}

function term {
  local -A opts
  local -a specs=(
    '-version'    'v=-version'
    '-program'    'p=-program'
    '-session-id' 'i=-session-id'
  )
  zparseopts -D -E -M -A opts - $specs[@] || return 2
  if [[ ${(v)#opts} -eq 0 ]]; then
    print -- "$TERM"
  fi
  if [[ ${+opts[--program]} -eq 1 ]]; then
    print -- "$TERM_PROGRAM"
  fi
  if [[ ${+opts[--version]} -eq 1 ]]; then
    print -- "$TERM_PROGRAM_VERSION"
  fi
  if [[ ${+opts[--session-id]} -eq 1 ]]; then
    print -- "$TERM_SESSION_ID"
  fi
}

function group {
  local REPLY
  if [[ "$1" =~ ^[0-9]+ ]]; then
    REPLY="${(k)usergroups[(R)$1]}"
  else
    REPLY="${usergroups[$1]}"
  fi
  if [[ -z "$REPLY" ]]; then
    error -1 -m 'no such user group: ${1}'
  fi
  printf '%s: %s\n' "$1" "$REPLY"
}





# statt - stat time
function {statt,filetime} {
  local statfmt='File:%t%SN%nAccess:%t%Sa%nModify:%t%Sm%nChange:%t%Sc%nBirth:%t%SB'
  stat -f "$statfmt" "$@"
}


# random-bytes - generate random bytes.
function random-bytes {
  local -i count=${1:-1}
  command dd \
    bs=1 count=$count \
    </dev/random 2>/dev/null
}

# zero-bytes - generate zero bytes.
function zero-bytes {
  local -i count=${1:-1}
  command dd \
    bs=1 count=$count \
    </dev/zero 2>/dev/null
}


# touchx - touch a file and make it executable
function touchx {
  local file="$1"
  touch $file
  chmod +x $file
}


# website-ip - print ip of the website
function website-ip {
  local website="${1//http(s|):\/\//}"
  command ping -c1 $website | awk 'NR==1 {gsub(/[^1-9.]/, "", $3); print $3}'
}



function find-idential-files {
  local file="$1"
  local dir="$2"
  [[ $# -lt 2 ]] && error -1 -m 'not enough arguments'
  local other_file
  for other_file in $dir/*(.,@N); do
    if [[ ! -f $other_file ]] continue
    if [[ $file == $other_file ]] continue
    if command diff -q -s $file $other_file >/dev/null; then
      print -P "Files ${fg[green]}$file${fg[default]} and ${fg[green]}$other_file${fg[default]} are idential"
    fi
  done
}

function find-all-idential-files {
  local dir="$1"
  [[ $# -lt 1 ]] && error -1 -m 'not enough arguments'
  local file
  for file in $dir/*(.,@N); do
    find-idential-files $file $dir
  done 
}
