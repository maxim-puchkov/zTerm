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
# User functions
if [[ -e ~/private/zsh/functions/include.zsh ]]; then
  source ~/private/zsh/functions/include.zsh
fi
# iTerm 2
if [[ -e ~zdot/.iterm2/.iterm2_shell_integration.zsh ]]; then
  source ~zdot/.iterm2/.iterm2_shell_integration.zsh
fi

unalias run-help
autoload -Uz run-help
autoload -Uz ~zdot/{site-functions,functions,completions}/*






#
export REF_ZDOT=($(< $ZTERM/etc/source.zsh))
preexec_functions+=(ref)



function preexec_test() {
  print -- $'\n\n'
  print-var @
  print "$0. [${#}]=$@"
  print -- $'\n\n'
}


function indentation_prefix() {
  typeset -x BEGIN='\e[36m'
  typeset -x END='\e[0m'
  typeset -x SYMBOL='>'
  printf '%b%s%s %b\n' "$BEGIN" "$@" "$SYMBOL" "$END"
}
function prefix() {
  typeset -x BEGIN='\e[36m'
  typeset -x END='\e[0m'
  typeset -x SYMBOL='>'
  printf '%b%s%s %b\n' "$BEGIN" "$@" "$SYMBOL" "$END"
}

function @input() {
  typeset INS=$(indentation_prefix $0)
  trap '{
    print -r -u2 -- "$(esc0 2,96 -t "'$0' " 22 -t "$0")>  "\
      "$(esc0 4 -t "argc"): $#, "\
      "$(esc0 4 -t "argv"): {${(kvj:, :)@}}"
  }' EXIT
}
