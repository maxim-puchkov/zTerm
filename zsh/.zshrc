# User-specific z-shell shell configuration.




fpath=($ZDOTDIR/site-functions $fpath)
autoload readf


#MARK: - TEMP
f=~/var/lines
export TEMP_THEME_N=${$(< ~/var/TEMP_THEME_N):-1}
#MARK:   TEMP -



#MARK: - Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"

# Themes
readf -e '#*' themes < "$ZDOTDIR/etc/themes.oh-my-zsh"
readf -e '#*' plugins < "$ZDOTDIR/etc/plugins.oh-my-zsh"

if [[ ! -v ZSH_THEME ]]; then
    ZSH_THEME=$themes[1]
    print -P -- "%F{5}ZSH theme is %U$ZSH_THEME%u (n = $TEMP_THEME_N)%f"
    # :-robbyrussell}
fi




#MARK: - Python Environment
export PYTHONSTARTUP="$ZTERM/Python/.pyenv"
export PYTHONPATH="$HOME/Library/Application Support/iTerm2/Scripts"
PYTHONPATH="$PYTHONPATH:$ZTERM/Python"
typeset -T PYTHONPATH pythonpath



# Source files
source "$ZSH/oh-my-zsh.sh"
source "$ZDOTDIR/.zload"


#MARK: - Z-Shell Settings
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
#zmodload zsh/mapfile
#typeset -a array; array=(${(f@)${mapfile[${f}]%$'\n'}});

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


function cleanf() {
    local bytes=256
    local file="$1"
    stat -f "$1: %z bytes" < $file
    hexyl -n $bytes < $file
    
}
