# User-specific z-shell shell configuration.


# Path to oh-my-zsh.
export ZSH="$ZDOTDIR/.oh-my-zsh"
export ZSH_PLUGINS="$ZDOTDIR/plugins.oh-my-zsh"

if [[ -z $ZSH_THEME ]]; then
    ZSH_THEME="af-magic" #"theunraveler"
fi

#plugins=($(< $ZDOTDIR/oh-my-zsh.plugins))
plugins=($(< "$ZSH_PLUGINS"))
function plugins() {
    $EDITOR "$ZSH_PLUGINS" #"$zterm/etc/plugins.oh-my-zsh"
}

source "$ZSH/oh-my-zsh.sh"
source "$ZDOTDIR/.zload"


# GNU Privacy Guard.
GPG_TTY=$(tty)
export GPG_TTY


# Preferred editor for local and remote sessions.
export EDITOR=('/usr/local/bin/nano' '--mouse')


# iTerm 2 shell integration.
if [[ -e "$ZDOTDIR/.iterm2_shell_integration.zsh" ]]; then
    source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
fi


# Python
export PYTHONSTARTUP="/Users/admin/Developer/Terminal/Python/.pyenv"
export PYTHONPATH="$DEV/Terminal/Python:$PYTHONPATH"


#
if [[ -f $SHELLSTARTUP ]]; then
    touch $SHELLSTARTUP
else
    export SHELLSTARTUP=$(tempfile 'time')
fi
trap "rm -f \"$SHELLSTARTUP\"" EXIT



bindkey '^X\x7f' backward-kill-line



precmd_functions+=( ref )
