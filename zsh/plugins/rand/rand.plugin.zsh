


function irand() {
    typeset -i max=${1:-100}
    typeset -gi rand=$(( $RANDOM % $max ))
    print "$rand"
}

function airand() {
    typeset -i max=$1
    integer count=$2
    typeset -ag rand=()
    
    integer i=1
    for i in {1..$count}; do
        rand+=$(irand $max)
    done
}

function randstr() {
    typeset -g
    dd if=/dev/random bs=1 count=10 NIL | xxd -
}
