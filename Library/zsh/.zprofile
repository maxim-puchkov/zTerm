#!/bin/zsh

#  .zprofile
#
#
# User-specific profile for interactive zsh(1) shells.


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

function ti() {
  setopt extendedglob
  # Number of times command will be executed
  typeset -i count=1000
  case "$1" in (-[0-9]##)
    let count="${1#-}"
    shift
  esac
  
  
  # Time command execution
  typeset cmd="$1"
  trap '{
  time (repeat '$count'; do
    '$cmd'
  done &>/dev/null) &&
  header "'$0'>  '"${(q)cmd}"'  (count: '$count')"
  } &' EXIT
}

# tldrs - run both `tldr' and `tealdeer' commands
#function tldrs() {
#  /usr/local/bin/tldr $argv
#  /usr/local/bin/tealdeer $argv
#}
#compdef '_tealdeer' tldrs

function header() {
  set -- " $@"
  print -P -- "%B%K{168}${(pr:$COLUMNS:)@}%k%b"
}



# shlvl - print shell command path and shell level
function shlvl lvl() {
  typeset -m -- 'SHELL' 'SHLVL'
}


# Go to working directory
if [[ -L ~/var/select/wd ]]; then
  cd -P ~/var/select/wd
fi
function wd() {
  ln -Fins ${argv:-$PWD} ~/var/select/$0
  return $?
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
