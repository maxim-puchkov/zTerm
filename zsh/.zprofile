# User-specific profile for interactive zsh(1) shells.


#MARK: - Z-Terminal
# Open Z-Terminal project.
function ztermx()   { open -a Xcode "$ztermxcodeproj" }
# zshenv - zsh environment for all shells.
function zenv()     { open -a Xcode "$ZSHENV" }
# zprofile - profile for zsh shells.
function zprof()    { open -a Xcode "$ZPROFILE" }
# zshrc - configuration file for zsh shells.
function zrc()      { open -a Xcode "$ZSHRC" }
function zload()    { open -a Xcode "$ZDOTDIR/.zload" }
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
var1='Hello, world!'
l1=( 'a' 'b' 'c' 'x' 'y' 'z' )
l2=( '1' '2' '3' )
l3=( {a..z} )
l4=( 'word' 'word abc' 'abc word' 'word abc word' )
l5=( '/path/to/a' '/path/to/b' '/c' 'c/d' )

typeset -A A1
for i in {1..26}; do
    A1[$i]=${(U)l3[$i]}
done
typeset -A A2
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
