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
