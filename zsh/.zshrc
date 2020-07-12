# User-specific z-shell shell configuration.


# Key bindings
bindkey '^X\x7f' backward-kill-line  # (⌘⌫)Command-Delete
zmodload zsh/zprof


# User's history file
export HISTFILE="$ZTERM/var/hist/$USER"


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

if [[ -e "$HOME/private/zsh/functions" ]]; then
    source "$HOME/private/zsh/functions"
fi


#
export REF_ZDOT=($(< $ZTERM/etc/source.zsh))
preexec_functions+=(ref)



function preexec_test() {
    print -- $'\n\n'
    print-var @
    print "$0. [${#}]=$@"
    print -- $'\n\n'
}
