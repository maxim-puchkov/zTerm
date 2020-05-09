# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.


source $ZDOTDIR/.zio
export LIST_HIGHLIGHT_COLOR='b_green'
for m in $langinfo[(I)ABMON_*]; do
    months+=($langinfo[$m])
done
time_regex="[1-9][0-9]?\s+(${(j:|:)months})\s+[0-9:]+\s+[1-2][0-9]{3}"
unset m months

function __list-ls() {
    local flags="$1"; shift
    script -q /dev/null command ls $flags "$@"
}
function __list-grep() {
    colorize_grep $LIST_HIGHLIGHT_COLOR \
        egrep --color='always' "$@"
}



# List all creation/access/change/modfication times
function ltA() {
    lt  "$@"; echo;
    lta "$@"; echo;
    ltc "$@"; echo;
    ltm "$@"; echo;
}
# List creation times
function lt() {
    print_h1 'File creation time'
    __list-ls -lFGHTUhrt "$@" |
        __list-grep --regexp $time_regex
        #$(date -j +'%e %b %Y')"
}
# List access times
function lta() {
    print_h1 'File access time'
    __list-ls -lFGHThrtu "$@" |
        __list-grep --regexp "[0-9]{1,2} [A-Z][a-z]{2} [0-9\:]{8} [0-9]{4}"
}
# List change times
function ltc() {
    print_h1 'File change time'
    __list-ls -lFGHTchrt "$@" |
        __list-grep --regexp "[0-9]{1,2} [A-Z][a-z]{2} [0-9\:]{8} [0-9]{4}"
}
# List modification times
function ltm() {
    print_h1 'Modification time'
    __list-ls -lFGHThrt "$@" |
        __list-grep --regexp "[0-9]{1,2} [A-Z][a-z]{2} [0-9\:]{8} [0-9]{4}"
}


# List [f]lags
function lf() {
    print_h1 'File flags'
    local tmp=$( tempfile )
    trap  'rm -f "$tmp"' EXIT
    command ls -lFGHOh "$@" > "$tmp"
    local flags=($(awk '{ print $5 }' "$tmp"))
    __list-ls -lFGHOh "$@" |
        __list-grep --regexp " (${(j:|:)flags}) "
}

# List file [S]izes
function lS() {
    print_h1 'File size'
    __list-ls -lFGHShr "$@" |
        __list-grep --regexp '([0-9][\.0-9]*)[BKMG]'
}



#unset -f __list-ls
#unset -f __egrep
#
#function __lf2__() {
#    user_groups=( $( dscl . list /Users | xargs -I _ id -gn _ ) ${(k)usergroups} )
#    ls -lO "$@" | perl -pe "s/ (${(j: |:)user_groups})\s+([^\s]+)/\1\t$(green "\2")/" |column -t
#}
