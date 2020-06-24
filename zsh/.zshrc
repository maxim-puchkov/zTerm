# User-specific z-shell shell configuration.


#MARK: - Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"
export HISTFILE="$ZTERM/var/hist/$USER"

# Themes
if [[ ! -v ZSH_THEME ]]; then
    ZSH_THEME=${$(head -n 1 $ZDOTDIR/etc/themes.oh-my-zsh):-robbyrussell}
fi

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


#MARK: - iTerm 2
# Shell integration
if [[ -e "$ZDOTDIR/.iterm2_shell_integration.zsh" ]]; then
    source "$ZDOTDIR/.iterm2_shell_integration.zsh"
fi
# Key bindings
bindkey '^X\x7f' backward-kill-line  # (⌘⌫)Command-Delete


# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
