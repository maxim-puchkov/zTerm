#!/bin/sh

(
ok_file='/usr/local/Terminal/var/run/CI/OK.txt'
date > $ok_file

error_file='/usr/local/Terminal/var/run/CI/Errors.txt'
date > $error_file

for script in /usr/local/Terminal/zsh/functions/*; do
  zsh -- $script &>/dev/null
  code=$?
  if [[ $code -eq 0 ]]; then
    printf '%s: %d\n' "$script" $code >> $ok_file
  else
    printf '%s: %d\n' "$script" $code >> $error_file
  fi
done )
