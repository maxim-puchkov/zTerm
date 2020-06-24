# User-specific profile for interactive zsh(1) shells.


#MARK: - Z-Terminal
# Open Z-Terminal Xcode project.
function xct()      { open -a Xcode "$zterm/Terminal.xcodeproj" }
alias zxc='xct'
# Open Services Xcode project.
function xcs()      { open -a Xcode "$zterm/Services.xcodeproj" }
# zshenv - zsh environment for all shells.
function zenv()     { open -a Xcode "$ZSHENV" }
# zprofile - profile for zsh shells.
function zprofile() { open -a Xcode "$ZPROFILE" }
# zshrc - configuration file for zsh shells.
function zrc()      { open -a Xcode "$ZSHRC" }
# zio - input/output display configuration.
function zio()      { open -a Xcode "$ZIO" }
# zalias - zsh aliases.
function zalias()   { open -a Xcode "$ZALIAS" }
# zexport - zsh exported environment variables.
function zexport()  { open -a Xcode "$ZEXPORT" }
function zutil()    { open -a Xcode "$ZUTIL" }
# znet - zsh network configuration.
function znet()     { open -a Xcode "$ZNET" }
# zmisc - miscellaneous zsh additions.
function zmisc()    { open -a Xcode "$ZMISC" }
# zcomp - zsh completion functions.
function zcomp()    { open -a Xcode "$ZCOMP" }

function zload()    { open -a Xcode "$ZDOTDIR/.zload" }










#zmodload zsh/mapfile
#typeset -a array; array=(${(f@)${mapfile[${f}]%$'\n'}});

function add_tests() {

# Compdef test function.
function foo() {
    printf '%s\n' "$(magenta 'Function' ${0})"
    printf 'Defined in %s\n' "$ZPROFILE"
}

# Compdef test function.
function bar() {
    printf '%s\n' "$(magenta 'Function' ${0})"
    printf 'Defined in %s\n' "$ZPROFILE"
}




#MARK: - Predefined Test Variables
l1=( 'a' 'b' 'c' 'x' 'y' 'z' )
l2=( '1' '2' '3' )
l3=( {a..z} )
l4=( 'word' 'word abc' 'abc word' 'word abc word' )
l5=( '/path/to/a' '/path/to/b' '/c' 'c/d' )
l6=( 'Bob' 'Alice' 'Bob' 'Charlie' 'Bob' 'Bob' 'Charlie' 'Alice' )

typeset -Ag Arr
Arr=(
    [name]='Jane'
    [surname]='Doe'
    [variable]='Arr'
    [message]='Hello, world!'
    [home]=~
    [dir]="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
)


typeset -Ag Assoc
Assoc=(
    'message'   'Hello, world!'
    'name'      'Bob'
    'age'       50
    'home'      ~
    'cmpt473'   ~/iCloud/SFU/10-*/473/assignments
    'phil310'   ~/iCloud/SFU/10-*/PHIL\ 310/assignments
)

typeset -Ag A1
A1=($(print -C2 {1..26} {A..Z}))

typeset -Ag A2
A2=( key1 val1 key2 val2 X-key3 val3 key4 X-val4 )




# 10-second long job.
function job10() {
    local tmpf=$(tempfile)
    printf 'Job 10 (%s) started on %s.\n' "$0" "$(date)" &>> $tmpf
    print-line &>> $tmpf
    local end=$(( $SECONDS + 10 ))
    while [[ $SECONDS -lt $end ]]; do
        printf '%s.\tRunning job #%s.\n' "$(date -j +'%T')" "$0" &>> $tmpf
        sleep 1
    done
    print-line &>> $tmpf
    printf 'Job 10 (%s) completed on %s.\n' "$0" "$(date)" &>> $tmpf
    printf '%s\n' "$(< $tmpf)"
    printf 'Printed %s characters to %s.\n' ${$(wc -c $tmpf)[1]} "$tmpf"
    rm $tmpf
    local exitcode=$?
    printf 'Exit %s.\n' $exitcode
    return $exitcode
}

}
