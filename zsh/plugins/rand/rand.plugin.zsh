


function irand() {
    integer max=$1
    integer rand=$(( $RANDOM % $max ))
    printf '%d' $rand
}

function airand() {
    integer max=$1
    integer count=$2
    typeset -ag rand=()
    
    integer i=1
    for i in {1..$count}; do
        rand+=$(irand $max)
    done
}

function randstr() {

}
