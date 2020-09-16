#!/usr/local/bin/zsh

integer ifd
exec {ifd}<&0

while read -u $ifd arg; do
    print -P -- "%N:%i [%t] Reading input from /dev/fd/${ifd}.";
    print -P -- "%N:%i [%t] Arg: '${arg}'."
done



exec {ifd}<& -
