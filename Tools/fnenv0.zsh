#!/bin/zsh


() (
  setopt xtrace
  export ZDOTDIR=$1
  printf '%d %s:\tBegin (version: %s, zdot: %s)\n' $$ "$0" "$ZSH_VERSION" "$ZDOTDIR"
  zsh -o sourcetrace
  local zsh_status=$?
  printf '%d %s:\tEnd (code: %d)\n\n' $$ "$0" $zsh_status
  return $zsh_status
)
