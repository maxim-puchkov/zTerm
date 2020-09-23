#!/bin/zsh

#  .zprofile
#
#
#  User-specific profile for interactive zsh(1) shells.


#code='if [[ ! -e var ]]; then
#  typeset -a files
#  files=( /tmp /tmp/.* /tmp/*.* /tmp/? /tmp/file-[:digit:]# )
#  while [[ -n "$1" ]]; do
#    builtin echo -p cd ~/Library/DES/ "/" not/a/path >outf
#    cat <outf <(ls -ld -- **/*(.@:t)) >>&|new.txt
#    grep -e '[a-z]' <<< "$(echo "string" "$1")"
#  done
#fi'
#
#function f() {
#  code=${argv:=$code}
#  print -rz "$0||
#$code"
#}

function hist() {
  if [[ -n $1 ]]; then
    fc -l 1 | grep -E $1 --color='always'
  else
    fc -l -40
  fi
}
function is() {
  { eval '[[ '"${(q)@}"' ]]; res=$?;' ||
    error -2 'Bad expression' }
  case $res in
    (0) boolval='true'  ;;
    (*) boolval='false' ;;
  esac
  printf 'Expression [[ %s ]] is \e[4m%s\e[0m\n' "$*" "$boolval"
  return $res
}






#
function getbytes() {
  local -i start end length file_size
  let start="($1 - 1)"
  let end="$2"
  # Check input file
  local file="$3"
  if [[ ! -e $file ]]; then
    error -1 'file ${file} does not exist.'
  fi
  # Check boundaries
  let file_size=$(stat -f '%z' $file)
  let length="($end-$start)"
  if [[ $((start+$length)) -gt $file_size ]] ||
     [[ $start -ge $end ]]; then
    error -1 -- 'bad values (start: ${start}, end: ${end}, length: ${length}) for file ${file} (size: ${file_size}).'
  fi
  xxd -s $start -l $length <$file
}

function getbytesr() {
  getbytes "$@" | xxd -r
}





# nbytes:  print size of file (number of bytes)
function nbytes() {
  stat -f '%z' -- "$@"
}
# filesize:  print size of file (human-readable)
function filesize() {
  simplify-size $(nbytes "$@")
}
# diffsize:  compare size of two files
function diffsize() {
  typeset -i size1 size2 diff
  size1=$(nbytes "$1")
  size2=$(nbytes "$2")
  let diff="($size1 - $size2)"
  printf '%s\n' "$(simplify-size $diff)"
}




#MARK: - Compress PDF
# Compress scanned files
function compress-pdf() {
  typeset workflow=~/Library/Services/'Compress Scanned File.workflow'
  integer replace_original_file=0
    
  # Parse options
  while [[ $1 =~ ^[-] ]]; do
    case $1 in
      # -r: replace original document - do not copy
      (-r|--replace-original-file)
        let replace_original_file=1
        shift ;;
      # bad option
      (*)
        (opt=$1 error +R -- 'bad option: ${opt}')
        shift ;;
    esac
  done
  
  
  # Get list of files
  typeset -a files=(${argv})
  if [[ ${#files} -eq 0 ]]; then
    error -1 -- 'files not found'
  fi
  integer count=0
  integer total_difference=0
  
  
  # Compress PDF Files
  printf '%s\n\nCompressing %i PDF documents...\n' "$(date -j)" ${#files}
  printf '%*s\n' $COLUMNS '' | tr ' ' '-'
  
  () {
    # Count compressed files and total compression
    local output=$1 error=$2
    local -i compressed_size  original_size
    local -i difference=0
    
    # Loop for each file
    local f
    for f in ${files}; do
      # Copy and rename original files (add ~orig suffix)
      if [[ $replace_original_file -ne 1 ]] &&
         [[ ! -e "${f:r}~orig.pdf" ]]; then
        cp -i -- "$f" "${f:r}~orig.pdf"
      fi
      
      # Apply the quartz filter workflow to PDF files
      printf '\e[2m%s\e[0m\e[36m>\e[0m \e[4m%s\e[0m: ' "$(date -j +'%X')" "${f:t}"
      let original_size=$(stat -f '%z' "${f}")
      /usr/bin/automator -i "$f" "$workflow" 1>|$output 2>|$error
      
      # Check workflow exit status
      case $? in
        # 0:  Compressed PDF file was saved in 'Compressed Files'
        0)
          let compressed_size=$(stat -f '%z' "${f}")
          let difference="($compressed_size - $original_size)"
          let total_difference="($total_difference + ($difference * -1))"
          printf 'file compressed from %s to %s \e[2m(%s)\e[0m\n'  "$(simplify-size $original_size)" "$(simplify-size $compressed_size)" "$(simplify-size $difference)"
          let count="($count + 1)" ;;
        
        # >0: File could not be compressed
        *)
          printf '\e[31mnot compressed\e[0m \e[2m(%s)\e[0m\n' "${$(cat <$error):-no description.)}" >&2 ;;
      esac
    done
  } =() =()
  
  # Print footer and exit
  printf '%*s\n\n' $COLUMNS '' | tr ' ' '-'
  printf 'Files compressed:\t%i\n' $count
  printf 'Memory freed:    \t%s\n' "$(simplify-size $total_difference)"
  return 0
}





#MARK: - ti
# ti:  measure time needed to complete a command N times
function ti() {
  # Number of times command will be executed
  typeset -i count=1000
  typeset -i output_once=0
  typeset command_output=/dev/null
  while [[ $1 =~ ^[-] ]]; do
    case "$1" in
      (-n)  # (-[0-9]##)
        let count="${2:=0}"  # ="${1#-}"
        if [[ $count -le 0 ]]; then
          error -1 'invalid number of repetitions: ${count}'
        fi
        shift 2 ;;
      (-o)
        command_output=/dev/stdout
        shift ;;
      (-1)
        output_once=1
        shift ;;
      (--)
        shift
        break ;;
      (*)
        opt="$1" error -1 -- 'Bad option ${opt}'
        return 1
      ;;
    esac
  done
  
  # Time command execution
  if [[ -z "$1" ]]; then
    error -1 -- 'command is not set.'
  fi
  typeset cmd="$1"
  trap '{
  header "'$0'>  '"${(q)cmd}"'  (count: '$count')"
  if [[ '$output_once' -eq 1 ]]; then
    {printf "Command: \"%s\"\nOutput: \"" "'$cmd'"
    '$cmd'
    printf "\"\n"} &>/dev/stdout
  fi
  time (repeat '$count'; do
    '$cmd'
  done &>'$command_output')
  } &' EXIT
}

function ascii_value() {
  set -- ${(s::)argv}
  local char
  for char; do
    python -c 'print(ord("'$char'"));'
  done
}

function help_bindkey() {
  local key cmd
  read -r -k2 -s key
  cmd="bindkey $(cat -vt <<<$key)"
  printf '%s\n\t->\t' "$cmd"
  $=cmd
}

# tldrs - run both `tldr' and `tealdeer' commands
#function tldrs() {
#  /usr/local/bin/tldr $argv
#  /usr/local/bin/tealdeer $argv
#}
#compdef '_tealdeer' tldrs



# header:  print line with background
function header() {
  set -- " $@"
  print -P -- "%B%K{168}${(pr:$COLUMNS:)@}%k%b"
}

# shlvl:  print shell command path and shell level
function shlvl lvl() {
  typeset -m -- 'SHELL' 'SHLVL'
}


# Go to working directory
#if [[ -L ~/var/select/wd ]]; then
#  cd -P ~/var/select/wd
#fi
#function wd() {
#  local new_target=${argv:-$PWD}
#  printf 'New link target: %s\n' "$new_target"
#  ln -Fins ${argv:-$PWD} ~/var/select/$0
#  return $?
#}


function wd() {
  local link_dir="$HOME/var/select/$0"
  if [[ ! -L $link_dir ]]; then
    error -1 'Not a symbolic link ${link_dir}'
    return 1
  fi
  
  case $# in
    (0)
      printf 'Changing working directory to: \e[36m%s\e[0m\n' "$(readlink $link_dir)"
      cd -P -- $link_dir
      return $? ;;
    (1)
      local new_target=${argv:-$PWD}
      printf 'New link target: \e[32m%s\e[0m\n' "$new_target"
      ln -Fins ${argv:-$PWD} $link_dir
      return $? ;;
    (*)
      return 1 ;;
  esac
}







#FIXME: Deprecated -
## Z-Terminal
#export lf=~/var/files/linesf
#export tf=~/var/files/textf
#export pf=~/var/files/patternsf
#export sf=~/var/files/'f i l e'
#export bf=~/var/files/brackets
#export lbf=/usr/local/Terminal/etc/labels
#export pmf=~/var/files/params
##


## SFU Named Directories
#hash -d sfu1=~sfu/01-Fall-2016
#hash -d sfu2=~sfu/02-Spring-2017
#hash -d sfu3=~sfu/03-Summer-2017
#hash -d sfu4=~sfu/04-Fall-2017
#hash -d sfu5=~sfu/05-Spring-2018
#hash -d sfu6=~sfu/06-Summer-2018
#hash -d sfu7=~sfu/07-Fall-2018
#hash -d sfu8=~sfu/08-Spring-2019
#hash -d sfu9=~sfu/09-Fall-2019
#hash -d sfu10=~sfu/10-Spring-2020
###


## Quick Open
# Open Z-Terminal Xcode project.
#function xct()      { open -a Xcode "$zterm/Terminal.xcodeproj" }
## Open Services Xcode project.
#function xcs()      { open -a Xcode "$zterm/Services.xcodeproj" }
## zshenv - zsh environment for all shells.
#function zenv()     { open -a Xcode "$ZSHENV" }
## zprofile - profile for zsh shells.
#function zprofile() { open -a Xcode "$ZPROFILE" }
## zshrc - configuration file for zsh shells.
#function zrc()      { open -a Xcode "$ZSHRC" }
## zio - input/output display configuration.
#function zio()      { open -a Xcode "$ZIO" }
## zalias - zsh aliases.
#function zalias()   { open -a Xcode "$ZALIAS" }
## zexport - zsh exported environment variables.
#function zexport()  { open -a Xcode "$ZEXPORT" }
#function zutil()    { open -a Xcode "$ZUTIL" }
## znet - zsh network configuration.
#function znet()     { open -a Xcode "$ZNET" }
## zmisc - miscellaneous zsh additions.
#function zmisc()    { open -a Xcode "$ZMISC" }
## zcomp - zsh completion functions.
#function zcomp()    { open -a Xcode "$ZCOMP" }
#function zload()    { open -a Xcode "$ZDOTDIR/.zload" }
###



# xmkfile:  make new files and open them in Xcode
function xmkfile() {(
  if [[ -z "$@" ]]; then
    if autoload -Uz usage; then
      usage 'Create a file an open it in ${XCODE}' \
          - 'xmakefile file.txt'
    fi
    return 1
  fi
  # Create and open files
  { touch "$@" && open -a "${XCODE:=Xcode}" "$@" }
)}


# ln-check: find and report broken symbolic links
function ln-check() {
  typeset TAG_NAME='DEV: Broken Symbolic Link'
  () {
    typeset -a broken_links
    broken_links=${(@f)$(find ${argv%'/'}/**/*(-@))}
    echo $broken_links
  } <=(echo obbb) 2>/dev/null
  
  tag -a $TAG_NAME $broken_links
  
#  if [[ $? -ne 0 ]]; then
#    error -1 'Bad'
#  fi
  echo $broken_links
}
