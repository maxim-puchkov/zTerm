#!/usr/bin/env zsh

alias echo='() { echo "---\n$@\n---" }'

x() {
    
    x_y() {
        trap "echo '[Trap 1] $0:<$@>'; trap \"echo '[Trap 2] $0:<$@>'\" EXIT;" EXIT
        echo "0=$0, ar=$@"
    }
    
    src=$0
    cmd=$1; shift
    
#    which ${src}_${cmd}
    ${src}_${cmd} "$@"
}

#x y

#x y
#return 123

#  run


function f() {
    cmds=("cd $HOME/iCloud" 'pwd -P' 'pwd -L')
    () {
        for cmd in $cmds; do
            $=cmd
        done
    }
}

#try { echo 'bob' } always { echo 'alice' }

return 123

trap 'echo "EXIT    status $?"'    EXIT
trap 'echo "HUP     status $?"'     HUP
trap 'echo "INT     status $?"'     INT
trap 'echo "QUIT    status $?"'    QUIT
trap 'echo "ILL     status $?"'     ILL
trap 'echo "TRAP    status $?"'    TRAP
trap 'echo "ABRT    status $?"'    ABRT
trap 'echo "EMT     status $?"'     EMT
trap 'echo "FPE     status $?"'     FPE
trap 'echo "KILL    status $?"'    KILL
trap 'echo "BUS     status $?"'     BUS
trap 'echo "SEGV    status $?"'    SEGV
trap 'echo "SYS     status $?"'     SYS
trap 'echo "PIPE    status $?"'    PIPE
trap 'echo "ALRM    status $?"'    ALRM
trap 'echo "TERM    status $?"'    TERM
trap 'echo "URG     status $?"'     URG
trap 'echo "STOP    status $?"'    STOP
trap 'echo "TSTP    status $?"'    TSTP
trap 'echo "CONT    status $?"'    CONT
trap 'echo "CHLD    status $?"'    CHLD
trap 'echo "TTIN    status $?"'    TTIN
trap 'echo "TTOU    status $?"'    TTOU
trap 'echo "IO      status $?"'      IO
trap 'echo "XCPU    status $?"'    XCPU
trap 'echo "XFSZ    status $?"'    XFSZ
trap 'echo "VTALRM  status $?"'  VTALRM
trap 'echo "PROF    status $?"'    PROF
trap 'echo "WINCH   status $?"'   WINCH
trap 'echo "INFO    status $?"'    INFO
trap 'echo "USR1    status $?"'    USR1
trap 'echo "USR2    status $?"'    USR2
trap 'echo "ZERR    status $?"'    ZERR
trap 'echo "DEBUG   status $?"'   DEBUG

hi() {
    return $1
}
hi 0
hi 123
read var
echo $var

#echo 'bob'
#() {
#func() {
#    return 2
#}
#func
#return 1
#}
#
#hi 100
return 0

source $ZIO
trap 'echo "hello"' EXIT


clid=30
function cl+() {
    printf '\e[%dm%s' $(( clid = clid + 1 )) "$1"
}
function cl-() {
    printf '\e[0m%s' "$1"
    (( clid = clid - 1 ))
}


function f() {
    cl+ $0
    echo "$0"
    echo $argv
    g $argv
    cl-
}
function g() {
    cl+ $0
    echo $argv
    cl-
}

f 1
g

exit 0

function imp() {
#    local args=<(read -r v /dev/stdin)
#    echo "$args"
#    printf '%s\n' "$@" | while read var; do
#    while read var; do
#        echo $var
#    done <<< "$@"
#less <&0
#while read line
#do
#  echo "$line"
#done < "${1:-/dev/stdin}"
#    in1="$@"
#    read -r in2
#    echo "Args:  <$in1> (in1)"
#    echo "Stdin: <$in2> (in2)"
    if [[ $# -gt 0 ]]; then
        printf '%s\n' "$@" | imp
        return 0
    fi
    
    while read -r line; do
        echo $line
    done
}

#echo "$@" | imp
#imp "$@"


source $ZDOTDIR/.zload

function gopts() {
    
    bluebg "$@"
    local identifier="$1"
    
    optstring="$2"
    bluebg $optstring
    shift 2
    
    local opt=''
    greenbg getopts "$optstring" opt
    while getopts "$optstring" opt; do
        echo "Option: $opt | Argument: $OPTARG"
        result[$opt]=$OPTARG
    done
    
#    ${(P)identifier}
    
    echo "ID: $identifier"
    echo "optstring: $optstring"
    echo "opts: ..."
    redbg '-----'
    echo "Keys: ${(k)__gopts}"
    echo
    echo "Values: rr${(v)__gopts}"
    echo "Full (${#__gopts}): $__gopts"
}

#gopts 'abc' "${@}"
typeset -A result
gopts result 'a:xb:Xc:x3' -a A1 -b B2 -c C3 NOT AN OPTION
echo;echo;
red 'RES'
echo ${(kv)result}


CVAL='hello1'
case $CVAL
