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


#MARK: - Z-Shell Settings
# GNU Privacy Guard
GPG_TTY=$(tty)
export GPG_TTY

CFD=$(pfd)
export CFD

v1='pfd'
export v1

v2='(pfd)'
export v2

#argc(=$(printf '%d' $ARGC))
#export argc

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
function zterm()    { cd "$ZTERM/$@"; }
# Go to ZDOTDIR.
function zdot()     { cd "$ZDOTDIR/$@"; }
# Go to SFU directory.
function sfu()      { cd "$SFU/$@"; }
# Go to Desktop.
function desk()     { cd "$HOME/Desktop/$@"; }
# Go to Library.
function lib()      { cd "$HOME/Library/$@"; }
# Go to Development root.
function dev()      { cd "$DEV/$@"; }
# Go to Projects directory.
function proj()     { cd "$DEV/Projects/$@"; }
# Go to Developer Library.
function devlib()   { cd "$devlib/$@"; }
# Go to Temporary Files.
function temp()     { cd "$tempdir/$@"; }
# Go to my var directory.
function var()      { cd "$HOME/var/$@"; }
# Go to launchd services.
function services() { cd "$HOME/Library/LaunchAgents/$@"; }
# Go to logs.
function logs()     { cd "$ZTERM/var/log/$@"; }

# Go to Test Files.
#function testdir()  { cd "$testdir/$@"; }




#MARK: - Python Environment
export PYTHONSTARTUP="$ZTERM/Python/.pyenv"
export PYTHONPATH="$ZTERM/Python:$PYTHONPATH"
export PYTHONPATH="$HOME/Library/Application Support/iTerm2/Scripts:$PYTHONPATH"
