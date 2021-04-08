#!/bin/zsh

#  .zlogin
#  /usr/local/zterm/Library/Z-Shell/.zlogin
#
#  User-specific environment for zsh(1) shells.
#  Created on October 9, 2020.


# zlogin
#
# Print user information on login.
function zlogin() {
  # Data file.
  local zlogin_enable="$ZTERMDIR/var/zlogin/enable"
  # User info:
  local -a fields=(
    "%F{4}User%f:  $USER:$(id -gn)"
    "%F{4}Shell%f: $SHELL"
    "%F{4}Home%f:  $HOME"
    "%F{4}WD%f:    $PWD"
  )
  
  # Do:
  case "$1" in
    # Set to enabled.
    (enable|on|+|1)
      echo 1 >|"$zlogin_enable" &&
      print -P -- "zlogin: changed to %F{2}enabled%f" ;;
    
    # Set to disabled.
    (disable|off|-|0)
      echo 0 >|"$zlogin_enable" &&
      print -P -- "zlogin: changed to %F{1}disabled%f" ;;
    
    # Print current status.
    (status)
      read -Er <$zlogin_enable ;;
    
    # Display if enabled.
    (*~^display)
      print -P -nr -C1 -- "${(@)fields}" ;;

    # Display.
    ("")
      if [[ $(read -Er <$zlogin_enable) -eq 1 ]]; then
        print -P -nr -C1 -- "${(@)fields}"
      fi ;;
  esac
  return 0
}




zlogin
