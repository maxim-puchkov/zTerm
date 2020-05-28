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
export EDITOR=('/usr/local/bin/nano' '--mouse')


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
