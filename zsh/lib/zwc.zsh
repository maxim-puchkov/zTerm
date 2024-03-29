#!/bin/zsh

#  zwc.zsh
#  Generated by mkzsh at 02:27pm.
#
#  Created by mpuchkov/506:20 on April 06, 2021.
#  ~zdot/lib/zwc.zsh





#?
function delete-zwc() {
  command find -H "${@:-.}" -name '*.zwc' -type f -maxdepth 1 -print -delete
}
function delete-zwc-old() {
  command find -H "${@:-.}" -name '*.zwc.old' -type f -maxdepth 1 -print -delete
}

function zdot-delete-zwc() {
  delete-zwc $ZDOTDIR
}














# return 0

##  zwc  ##
# Delete files in $ZDOTDIR/zwc.
function zwc-clean() {
  command find "$ZDOTDIR/zwc" -type f -mindepth 1 -maxdepth 1 -delete
}

# Autoload zwc files from $ZDOTDIR/zwc.
function zwc-autoload() {
  autoload -w $ZDOTDIR/zwc/*~*.old(-.)
}

# Compile everything in fpath to $ZDOTDIR/zwc.
function zwc-compile() {
  autoload -Uz zrecompile error
  local -A opts=( '--out' "$ZDOTDIR/zwc" )
  local -a specs=( '-out:' 'o:=-out'  '-clean' 'c=-clean' )
  if ! zparseopts -D -F -K -M -A opts - ${specs[@]} \
       2> >(error -I -d: -f3-); then
    return 1
  fi
  local outdir=$opts[--out]                       # @opt -o,--out: specify output directory
  if [[ ! -d $outdir ]]; then
    error -1 -m 'no such directory: ${outdir}'
  fi
  if [[ ${+opts[--clean]} -eq 1 ]]; then
    zwc-clean                                     # @opt -c,--clean: clean output directory
  fi
  for ((i=1; i <= $#fpath; ++i)); do
    local dir=$fpath[i]
    local zwc="$outdir/${${dir:t3}//\//_}.zwc"
    if [[ $dir == (.|..) || $dir == (.|..)/* ]]; then
      continue
    fi
    local -a files=()
    case $dir in
      *.zwc)       continue                  ;;   # skip compiled functions (.zwc)
      */plugins/*) files=( $dir/*.*sh(N-.) ) ;;   # oh-my-zsh plugin directories
      *)           files=( $dir/*(N-.)     ) ;;   # standard function directory
    esac
    if [[ -n $files ]]; then
      zrecompile -q -p -U -z "$zwc" $files
    fi
  done
}


if [[ ! -d "$ZDOTDIR/zwc" ]]; then
  mkdir "$ZDOTDIR/zwc" || return
fi

zwc-compile &!
zwc-autoload
