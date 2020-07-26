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


#MARK: - Source
# Oh-my-zsh
source "$ZSH/oh-my-zsh.sh"
# Z-Shell autosuggestions & syntax highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Z-Shell .z sources
if [[ -e ~zdot/include.zsh ]]; then
  source ~zdot/include.zsh
fi
# User functions
if [[ -e ~/private/zsh/functions/include.zsh ]]; then
  source ~/private/zsh/functions/include.zsh
fi
# iTerm 2
if [[ -e ~zdot/.iterm2/.iterm2_shell_integration.zsh ]]; then
  source ~zdot/.iterm2/.iterm2_shell_integration.zsh
fi


#MARK: - Autoload
unalias run-help
autoload -Uz run-help
autoload -Uz ~zdot/{site-functions,functions,completions}/*






#
#export REF_ZDOT=($(< $ZTERM/etc/source.zsh))
#preexec_functions+=(ref)



function preexec_test() {
  typeset -a preexec_command
  preexec_command=(${=2})
  typeset preexec_function=${preexec_command[1]}
  if [[ ${+functions[$preexec_function]} -eq 1 ]]; then
    unset -f "$preexec_function"
    autoload +X $preexec_function
  fi
}
#preexec_functions+=(preexec_test)

function @input() {
  trap '{
    print -r -u2 -- "$(esc0 2,96 -t "'$0' " 22 -t "$0")>  "\
      "$(esc0 4 -t "argc"): $#, "\
      "$(esc0 4 -t "argv"): {${(kvj:, :)@}}"
  }' EXIT
}
