


function irand() {
    typeset -i max=${1:-100}
    typeset -gi rand=$(( $RANDOM % $max ))
    print "$rand"
}

function airand() {
    typeset -i max count i
    max=${1:-100}
    count=${2:-5}
    typeset -ag rand=()
    for i in {1..$count}; do
        rand+=$(irand $max)
    done
}

function randstr() {
    typeset -g rand
    typeset -i length=$1
    if [[ $length -le 0 ]]; then
        length=5
    fi
    rand="$( dd if=/dev/random bs=1 count=$length NIL | xxd -p | cut -c-$length )"
    print -N "$rand"
}
