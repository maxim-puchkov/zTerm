#!/bin/zsh

function custom-fn.zsh() {
  print -P "function $0(${(s:, :)argv}) { '%N' '%^' '%l' '%y' }"
  integer c=${2:=123}
  print -Pc -- $'\e[1;45m'"Return: $c."$'\e[0m'
  return $c
}
