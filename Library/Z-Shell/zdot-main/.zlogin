#!/bin/zsh

#  .zlogin
#  /usr/local/zterm/Library/Z-Shell/.zlogin
#
#  User-specific environment for zsh(1) shells.
#  Created on October 9, 2020.


function zlogin() {
  case "$1" in
    (enable|on|1)
      echo '1' >|~var/data/zlogin_enable &&
      print -P -- "zlogin: %F{2}enabled%f" ;;
    
    (disable|off|0)
      echo '0' >|~var/data/zlogin_enable &&
      print -P -- "zlogin: %F{1}disabled%f" ;;
      
    (*) error -1 -m '${1} is not a valid argument' ;;
  esac
}


read -r zlogin_enable <~var/data/zlogin_enable
if [[ $zlogin_enable -eq 1 ]]; then
  typeset -a fields=(
    "%F{4}User%f: $USER:$(id -gn) ($SHELL)"
    "%F{4}Home%f: $HOME"
    "%F{4}WD%f:   $PWD"
  )
  print -P -n -C1 -- $fields
fi
unset zlogin_enable
