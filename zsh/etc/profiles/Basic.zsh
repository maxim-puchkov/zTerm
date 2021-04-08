#  Default.zsh
#  iTerm profile configuration
#
#  Created by mpuchkov/506:20 on March 27, 2021.
#  private/zsh/iterm-profiles/Default.zsh


### Default Profile ##
#path+=( "$HOME/bin" )
#export LS_COLWIDTHS="8:3:3:0:6:8:4:0"
#
#
## Oh-my-zsh
#export ZSH="$ZDOTDIR/oh-my-zsh"                             # oh-my-zsh directory
#ZSH_CUSTOM="$ZDOTDIR/custom"                                # Custom scripts
#ZSH_THEME="powerlevel10k/powerlevel10k"                     # Theme
#plugins=(                                                   # Plugins
#  git osx
#  iterm2 zfn
#)
#source "$ZSH/oh-my-zsh.sh"


setopt norcs
setopt sourcetrace
setopt verbose


source /usr/local/share/iterm2/shell_integration/iterm2_shell_integration.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
