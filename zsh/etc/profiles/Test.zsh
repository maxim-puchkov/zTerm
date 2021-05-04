#!/bin/zsh

setopt no_rcs
setopt sourcetrace



select testfile in "$ZDOTDIR/test"/*(.); do
  print -P "%F{1}Testing file: $testfile%f"
  break
done

source "$testfile"
