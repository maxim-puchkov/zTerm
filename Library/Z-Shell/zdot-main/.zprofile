#!/bin/zsh

#  .zprofile 
#  /usr/local/zterm/zsh/.zprofile
#
#  User-specific profile for interactive zsh(1) shells.
#  Created on October 9, 2020.


# log
function log() {
  [[ $# -eq 0 ]] && return 1
  local filename="$(date -j +'%F_%T')_${1}"
  if ! (type -- $1 &>/dev/null); then
    return 1
  fi
  $argv &>~log/Commands/$filename
  return $?
}





# nf
#
# Print number of files in directories.
#
# Usage:
# nf [-r [-d <depth>]] [dir [dir...]]
function nf() {
  # Options
  local -A opts
  local -a specs
  specs=( '-recursive' 'r=-recursive'
          '-depth:'    'd:=-depth' )
  zparseopts -D -E -M -A opts - $specs ||
  error -2 'invalid options'
  set -- ${argv:=$PWD}

  # Recursive
  if [[ ${+opts[--recursive]} -eq 1 ]]; then
    # Recursion depth
    local depth=""
    if [[ ${+opts[--depth]} -eq 1 ]]; then
      depth="-maxdepth ${opts[--depth]}"
    fi
    set -- "${(@fo)$(find -L -- $argv -type d $=depth)}"
  fi

  # Get number of files in directories
  local -A result
  local -i num total_num
  local dir
  for dir; do
    find -L -- $dir -mindepth 1 -maxdepth 1 |
    wc -l |
    read num
    
    let total_num="$total_num + $num"
    result+=("$dir" "$num")
  done

  # Print result
  if [[ ${#result} -eq 1 ]]; then
    print -r -- ${(v)result}
  else
    print -nr -aC2 -- ${(@Dkv)result}
    print -P -- "%F{7}${(l:$COLUMNS::-:)}%f"
    print -- "Total: $total_num files"
  fi

  return $?
}











# list-times:   Display AMCB times for file.
# usage:       `list-times [-amcb] file...'
function list-times () {
  # Configure time options
  local -a opts=()
  while [[ "$1" =~ ^- ]]; do
    opts+=( ${(s::)1##-#} )
    shift
  done
  [[ "$1" == '--' ]] && shift
  
  # Check files
  if [[ $# -eq 0 ]]; then
    error -1 'Files are not specified'
  fi
  
  # If not specified, display file birth time
  if [[ ${#opts} -eq 0 ]]; then
    opts=( b )
  fi
  # Stat format
  local opt stat_fmt
  stat_fmt='File:      %t%N%n'
  for opt in $opts; do
    case "$opt" in
      (a) stat_fmt+='Accessed:%t%Sa%n'   ;;
      (m) stat_fmt+='Modified:%t%Sm%n'   ;;
      (c) stat_fmt+='Changed: %t%Sc%n'   ;;
      (b) stat_fmt+='Birthed: %t%SB%n'   ;;
      (*) error -1  'bad option: ${opt}' ;;
    esac
  done
  
  # Time format: 'mmm dd yyyy[ tab ]HH:MM:SS'
  local strf_time_fmt='%b %d %Y%t%X'
  stat -f "${stat_fmt}%n" -t $strf_time_fmt $argv
  return 0
}



function mktdir() {
  local root_dir=~/var/dev/tdirs
  local dir_name='td'
  local -i id=1
  read id <~share/tdir.id
  local tdir="${root_dir}/${dir_name}${id}"
  /bin/mkdir -- "$tdir"  2> >(error)
  if [[ $? -eq 0 ]]; then
    printf '%i\n' $(( id + 1 )) >~share/tdir.id
    cd $tdir
    pwd
  fi
}
# Last test directory
function ltdir() {
  cd ~/var/dev/tdirs/*(omY1)
  pwd
}



function recent() {
  set -- ${argv:=$PWD}
  local dir
  for dir; do
    (cd -q $dir && /bin/ls -ld -BFGHhk -- **(OmY10))
  done
}

function web() {
  /usr/bin/open -a Safari "https://${argv}"
}




#MARK: - History
# Search history or list recent events
function hist() {
  if [[ -n "$1" ]]; then
    fc -l 1 |
    grep -E $1 --color='always'
  else
    fc -l -40
  fi
}

# History statistics for N commands
function histat() {
  local -i N=${1:=25}
  fc -l 1    |
  awk '(! /\.\//) { CMD[$2]++; count++; }
              END { for (a in CMD) {print CMD[a] " " CMD[a]*100/count "% " a;} }' |
  sort -n -r |
  head -n $N |
  column -t  |
  nl
}
#MARK: -
