# User-specific z-shell shell configuration.


#MARK: - Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"
# Themes
export ZSH_THEMES="$ZDOTDIR/themes.oh-my-zsh"
if [[ -z $ZSH_THEME ]]; then
    ZSH_THEME=${$(< $ZSH_THEMES)[1]:-robbyrussell}
fi
# Plugins
export ZSH_PLUGINS="$ZDOTDIR/plugins.oh-my-zsh"
export plugins=($(< $ZSH_PLUGINS))
# Source files
source "$ZSH/oh-my-zsh.sh"
source "$ZDOTDIR/.zload"


# GNU Privacy Guard
GPG_TTY=$(tty)
export GPG_TTY


# Preferred editor for local and remote sessions
export EDITOR='/usr/local/bin/nano --mouse'


#
export REF_ZDOT=($(< $ZTERM/etc/source.zsh))
preexec_functions+=(ref)


#
zmodload zsh/zprof




#MARK: - iTerm 2
# Shell integration
if [[ -e "$ZDOTDIR/.iterm2_shell_integration.zsh" ]]; then
    source "$ZDOTDIR/.iterm2_shell_integration.zsh"
fi
# Key bindings
bindkey '^X\x7f' backward-kill-line  # Command-Delete




#MARK: - File Directories
# Go to Z-Terminal directory.
function zterm()    { cdp "$ZTERM/$@" }
# Go to SFU directory.
function sfu()      { cdp "$SFU/$@" }
# Go to Desktop.
function desk()     { cdp "$HOME/Desktop/$@"; }
# Go to Library.
function lib()      { cdp "$HOME/Library/$@"; }
# Go to Development root.
function dev()      { cdp "$DEV/$@"; }
# Go to Developer Library.
function devlib()   { cdp "$devlib/$@"; }
# Go to Temporary Files.
function temp()     { cdp "$tempdir/$@"; }
# Go to my var directory.
function var()      { cdp "$HOME/var/$@"; }
# Go to launchd services.
function services() { cdp "$HOME/Library/LaunchAgents/$@"; }
# Go to logs.
function logs()     { cdp "$ZTERM/var/log/$@"; }

# Go to Test Files.
#function testdir()  { cdp "$testdir/$@"; }




#MARK: - Python Environment
export PYTHONSTARTUP="$ZTERM/Python/.pyenv"
export PYTHONPATH="$ZTERM/Python:$PYTHONPATH"


function _get-option-names() {
    index=$(( ${@[(i)-*]} - 1 ))
    set -- ${@:1:$index}
    print -- "short $1"
    print -- "long  ${2:-''}"
}


function _get-arguments() {
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
                set -A option_names $(get-option-names ${(q)@:2})
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








function _parse-input() {
    
    optstring=${@[-1]}
#    red $optstring
    set -- ${@:1:-1}
    
    greenbg "OptIDs    <$@>"
    redbg   "Optstring <$optstring>"
#    red $@ $#
    
#    blue $1
#    typeset -a
    while [[ $1 =~ '^-' ]]; do
#        cyan "  -- \$1 = <$1>"
        case $1 in
            -o|--option)
                typeset -A option_names
#                blue "$(get-option-name ${(q)@:2})"
                set -A option_names $(get-option-names ${(q)@:2})
#                set -A option_name $(_getopt ${@:2})
#                echo "OA="$option_id
                shift ${#option_names}
                
#                red "OK"; echo; echo
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
    blue "Remaining <$@> ($#), next \$1 = <$1>"
    
    arr=($@)
}


function tests() {
#    default_input="runtest -opt1 val1 -opt2 val2 -flag1 OTHER ARGS"
#    input="${@:-$default_input}"
#    _parse-input -o opt1 opt2 -f flag1 "$input"
    
    default_input="-x 100 -y 200 -z 300 my_graph.png"
    input="${@:-$default_input}"
    get-arguments -o x xpos  -o y ypos  -o z  -f "$input"
#    parse-input -o OPT1 OPT2 -f FLAG1 "
}
