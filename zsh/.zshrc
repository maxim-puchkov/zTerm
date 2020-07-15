# User-specific z-shell shell configuration.


# Key bindings
bindkey '^X\x7f' backward-kill-line  # (⌘⌫)Command-Delete

# Load modules
zmodload zsh/zprof
zmodload zsh/zutil
zmodload zsh/zselect




#MARK: - Oh-my-zsh
export ZSH="$ZDOTDIR/.oh-my-zsh"
if [[ ! -v ZSH_THEME ]]; then
  ZSH_THEME=${$(head -n 1 $ZTERM/etc/themes.oh-my-zsh):-robbyrussell}
fi
# User's history file
export HISTFILE="$ZTERM/var/hist/$USER"


# Source files
source "$ZSH/oh-my-zsh.sh"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~zdot/.zexport
source ~zdot/.zio
source ~zdot/.zalias
source ~zdot/.zutil
source ~zdot/.znetwork
source ~zdot/.zmisc
source ~zdot/.zcomp
source ~zdot/.ztest

unalias run-help
autoload -Uz run-help
autoload -Uz ~zdot/{site-functions,functions,completions}/*


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
