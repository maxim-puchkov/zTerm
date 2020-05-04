# User-specific z-shell shell configuration.


# Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"
export ZSH_PLUGINS="$ZDOTDIR/plugins.oh-my-zsh"

if [[ -z $ZSH_THEME ]]; then
    ZSH_THEME="af-magic" #"theunraveler"
fi

plugins=($(< "$ZSH_PLUGINS"))
function plugins() { $EDITOR "$ZSH_PLUGINS" }

source "$ZSH/oh-my-zsh.sh"
source "$ZDOTDIR/.zload"


# GNU Privacy Guard
GPG_TTY=$(tty)
export GPG_TTY


# Preferred editor for local and remote sessions
export EDITOR=('/usr/local/bin/nano' '--mouse')


# iTerm 2 shell integration
if [[ -e "$ZDOTDIR/.iterm2_shell_integration.zsh" ]]; then
    source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
fi


#
export REF_ZDOT=($(< $ZTERM/etc/source.zsh))
preexec_functions+=(ref)


#
zmodload zsh/zprof

#
bindkey '^X\x7f' backward-kill-line


# Go to Desktop.
function desk()     { cdp "$HOME/Desktop/$@"; }
# Go to Development root.
function dev()      { cdp "$DEV/$@"; }
# Go to Developer Library.
function devlib()   { cdp "$devlib/$@"; }
# Go to Temporary Files.
function temp()     { cdp "$tempdir/$@"; }
# Go to Test Files.
#function testdir()  { cdp "$testdir/$@"; }
# Go to my var directory.
function var()      { cdp "$HOME/var/$@"; }
# Go to launchd services.
function services() { cdp "$HOME/Library/LaunchAgents/$@"; }
# Go to logs.
function logs()     { cdp "$ZTERM/var/log/$@"; }




#MARK: - Python Environment
export PYTHONSTARTUP="$ZTERM/Python/.pyenv"
export PYTHONPATH="$ZTERM/Python:$PYTHONPATH"

