# User-specific z-shell shell configuration.


# Key bindings
bindkey '^X\x7f' backward-kill-line  # (⌘⌫)Command-Delete
zmodload zsh/zprof


# User's history file
export HISTFILE="$ZTERM/var/hist/$USER"=


#MARK: - Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"
# Themes
if [[ ! -v ZSH_THEME ]]; then
    ZSH_THEME=${$(head -n 1 $ZTERM/etc/themes.oh-my-zsh):-robbyrussell}
fi
# Source files
source "$ZSH/oh-my-zsh.sh"
source "$ZDOTDIR/.zload"


#MARK: - iTerm 2
# Shell integration
if [[ -e "$ZDOTDIR/.iterm2_shell_integration.zsh" ]]; then
    source "$ZDOTDIR/.iterm2_shell_integration.zsh"
fi

if [[ -e "$HOME/private/uconf.zsh" ]]; then
    source "$HOME/private/uconf.zsh" 
fi


#
export REF_ZDOT=($(< $ZTERM/etc/source.zsh))
preexec_functions+=(ref)


arr_imatch() {(
    typeset -a flags=($1)
    typeset -a subscripts=($2)
    shift 2
    typeset -ax arr
    if [[ -z $arr ]]; then
        arr=($argv)
    fi
    eval 'print -- ${arr[('$flags')'$subscripts']}'
)}

arr_split() {
    typeset sym=$1
    
    shift
    typeset -i index=${argv[(i)$~sym]}
    typeset -ag left right
    left=(${argv[1,$index]})
    right=(${argv[$index+1,#]})
    print -- "left=($left)"
    print -- "right=($right)"
}

