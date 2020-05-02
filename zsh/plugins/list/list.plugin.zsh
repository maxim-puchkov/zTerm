# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.


source $ZDOTDIR/.zio
export LIST_HIGHLIGHT_COLOR='green'

function __list-ls() {
    local flags="$1"; shift
    script -q /dev/null command ls $flags "$@"
}
local function __list-grep() {
    colorize_grep $LIST_HIGHLIGHT_COLOR \
        egrep --color='always' \
              "$@"
}


# List [m]odification times
function lm() {
    print_h1 'Modification time'
    __list-ls -lFGHThrt "$@" | __list-grep --regexp "[0-9]{1,2} [A-Z][a-z]{2} [0-9\:]{8} [0-9]{4}"
}

# List creation [t]imes
function lt() {
    print_h1 'File creation time'
    __list-ls -lFGHTUhrt "$@" | __list-grep --regexp "[0-9]{1,2} [A-Z][a-z]{2} [0-9\:]{8} [0-9]{4}"
}

# List [f]lags
function lf() {
    print_h1 'File flags'
    local tmp=$( tempfile )
    trap  'rm -f "$tmp"' EXIT
    command ls -lFGHOh "$@" > "$tmp"
    local flags=($(awk '{ print $5 }' "$tmp"))
    __list-ls -lFGHOh "$@" | __list-grep --regexp " (${(j:|:)flags}) "
}

# List file [S]izes
function lS() {
    print_h1 'File size'
    __list-ls -lFGHShr "$@" | __list-grep --regexp '([1-9][\.0-9]*)[BKMG]'
}



#unset -f __list-ls
#unset -f __egrep
#
#function __lf2__() {
#    user_groups=( $( dscl . list /Users | xargs -I _ id -gn _ ) ${(k)usergroups} )
#    ls -lO "$@" | perl -pe "s/ (${(j: |:)user_groups})\s+([^\s]+)/\1\t$(green "\2")/" |column -t
#}
