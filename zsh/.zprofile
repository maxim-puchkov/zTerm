# User-specific profile for interactive zsh(1) shells.


#MARK: - Z-Terminal
# Open Z-Terminal project.
function zterm()    { open -a Xcode "$ztermxcodeproj" }
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
# zcomp 
function zcomp()    { open -a Xcode "$ZCOMP" }


#source "$ZDOTDIR/.zload"
#
#
#function foo() {
#    echo "Running $0..."
#    echo "Raising error..."
#
#    error "$0"
#    red "Exiting $0..."
#    return 0
#}
#
## Compdef test function.
#function bar() {
#    SYNTAX="$0 -opt=string var1 var2"
#    local var1="value-1"
#    local var2="value-2"
#    syntax_check "$SYNTAX" var1 var2
#    printf '%s\n' "$(magentabg 'Function' ${0})"
#    printf 'Defined in %s\n' "$ZPROFILE"
#}

function analyze() {
    function __analyze() {
        printf "\n$(magenta 'Analyzing') $(bmagenta %s)...\n" "$@"
#        setopt xtrace
        local trace=$(zsh --xtrace -c "$@" 2>&1)
        printf "$(Info %s)\n" "$trace"
#        setopt noxtrace
        printf "$(magenta %s)\n\n" 'Analysis complete...'
    }
    echo "ARGS: <$@>"
    __analyze "$@"
}



function stderr() {
    printf '%s' 2>&1
}
