#!/usr/bin/env /usr/local/bin/zsh

#autoload +Uz save_array
autoload +Uz read_array
#
#CONFIG="$DEV/Terminal/.config/crontab/system-appearance"
#read_array settings $CONFIG
#echo $settings
#
#
#hash=("${(@)array1:^array2}")



#SETTINGS=(enabled begin_time end_time)

#while read setting; do
#    echo "cron setting = $setting"
#done < $SETTINGS
source $ZDOTDIR/.zio

typeset -A appearances
CFG_DIR="$DEV/Terminal/.config/crontab/system-appearance"
read_array appearances $CFG_DIR/appearances


hour=${1:-$( date +'%H' )};

if [[ $hour -ge 8 ]] && [[ $hour -lt 20 ]]; then
  action='off'
else
  action='on'
fi

current=$( /usr/local/bin/dark-mode status )
if [[ $current -eq $action ]]; then
  printf '%s %s\n' "${appearances[$current]}" 'appearance is already enabled.' >&2
  return 1
fi

/usr/local/bin/dark-mode $action &> /dev/null
