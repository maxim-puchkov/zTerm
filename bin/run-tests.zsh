#!/usr/local/bin/zsh




f() {
    if ! (whence $1) ; then
        echo 'YES'
    else
        echo 'NO'
    fi
}

g() {
    if (! whence $1) ; then
        echo 'YES'
    else
        echo 'NO'
    fi
}

h() {
    if ! (whence $1 &>/dev/null) ; then
        echo 'YES'
    else
        echo 'NO'
    fi
}

f $@
g $@
h $@

return 0

#get-argument-name "b,bobby"
#return 0

function get-arguments() {
    # Argument short and long names
    function get-argument-name() {
        typeset str="$@"
        typeset split_index=${str[(I)[,]]}
        if [[ $split_index -eq 0 ]]; then
            short_name=$str
            long_name=''
        else
            short_name=${str[1,$(( $split_index - 1 ))]}
            long_name=${str[$(( $split_index + 1 )),${#str}]}
        fi
    }
    
    # Option value
    function set-option() {
        set -- ${=optstring}
        typeset index=${@[(I)-$short_name]}
        typeset optval=''
        if [[ $index -ne 0 ]]; then
            optval=${@[(w)$(( $index + 1 ))]}
            set-value $optval
#            optlist[$short_name]=$optval
#            optlist[$long_name]=$optval
        else
            index=${@[(I)--$long_name]}
            if [[ $index -ne 0 ]]; then
                optval=${@[(w)$(( $index + 1 ))]}
                set-value $optval
#                optlist[$short_name]=$optval
#                optlist[$long_name]=$optval
            fi
        fi
    }
    
    function set-value() {
        if [[ -n $short_name ]]; then
            optlist[$short_name]="$@"
        fi
        if [[ -n $long_name ]]; then
            optlist[$long_name]="$@"
        fi
    }
    
#    function set-option() {
#        set-value "$@"
#    }
#
    function set-flag() {
        set-value 'on'
    }
    
    
    optstring=${=@[-1]}
    set -- ${=@:1:-1}
    
    typeset -Ag optlist
    optlist=()
    while [[ $1 =~ '^-' ]]; do
        case $1 in
            -o|--option)
                get-argument-name $2
#                print -P -- "%F{1}$short_name %F{2}$long_name%f"
                set-option
                shift
            ;;
            -f|--flag)
                get-argument-name $2
                set-flag
                shift
            ;;
        esac
        shift
        
    done
}



get-arguments $1 $2
 print -P -- "KEY %F{6}${(k)optlist}%f"
print -P -- "VAL %F{4}${(v)optlist}%f"



echo
echo 'Do tests? (y)'
read input
if [[ $input == 'y' ]]; then
    echo "*** 1 ***"
    OPTS="-o d,dir -o v,value"
    ARGS="-d homedir bobby"
    get-arguments "$OPTS" "$ARGS"
     print -P -- "KEY %F{6}${(k)optlist}%f"
    print -P -- "VAL %F{4}${(v)optlist}%f"


    echo "\n\n*** 2 ***"
    OPTS="$@"
    ARGS="-a Alpha -b Bravo"
    get-arguments "$OPTS" "$ARGS"
     print -P -- "KEY %F{6}${(k)optlist}%f"
    print -P -- "VAL %F{4}${(v)optlist}%f"

    echo "\n\n*** 3 ***"
    OPTS="-o t,test"
    ARGS="$@"
    get-arguments "$OPTS" "$ARGS"
     print -P -- "KEY %F{6}${(k)optlist}%f"
    print -P -- "VAL %F{4}${(v)optlist}%f"
fi

return 0











function get-argument-name() {
    index=$(( ${@[(i)-*]} - 1 ))
    set -- ${@:1:$index}
    print -- "short $1"
    print -- "long  ${2:-''}"
}


function get-arguments() {
    optstring=${@[-1]}
    set -- ${@:1:-1}
    
    greenbg "OptIDs    <$@>"
    redbg   "Optstring <$optstring>"
    
    typeset -Ag opts
    typeset -Ag opts_long
    
    while [[ $1 =~ '^-' ]]; do
        case $1 in
            -o|--option)
                typeset -A option_names
                set -A option_names $(get-argument-name ${(q)@:2})
                shift ${#option_names}
                blue $option_names
                opts[$option_names[short]]="hello short"
                opts_long[$option_names[long]]="hello long"
            ;;
            -f)
            
            ;;
#            -f|--flag)
#                option_short=$2
#                option_long=$3
#                if [[ ! $option_long =~ '^-' ]]; then
#                    yellow $option_long
#                fi
#                cyan "Option short[$option_short], long[$option_long]"
#                red "opt = $2"
#                blue "longopt = $3"
#            ;;
        esac
        shift
    done
    echo
    
    
    bblue "Remaining <$@> ($#)"
    blue  "next \$1 = <$1>"
    
#    arr=($@)/
}




#arr=(-o x,z

#TEST_1="-opt1 "
#get-arguments -o g get -o



g() { echo "$#) $@; \$1=$#1"; }
g "$@"
