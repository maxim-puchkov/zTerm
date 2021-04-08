#!/bin/zsh

# term3
# Oh-my-zsh Theme
#
#
#


# Settings
typeset -g reset_color=$fg[default]
typeset -g OK='$( [[ $LINENO -ne 1 ]] && printf "OK"; )'
typeset -g return_code='%(?.%{'$fg[green]'%}'$OK'.%{'$fg[red]'%}%? ↵)%{'$reset_color'%}'



# primary prompt
PS1='$FG[237]${(l:$COLUMNS::-:)}%{$reset_color%}
$FG[032]%~$(git_prompt_info) $FG[063]!%h$FG[105]%(!.#.»)%{$reset_color%} '


PS2='%{$FG[012]%} >  %{$reset_color%}'



# right prompt
#RPS1='${return_code}'
#RPS1+=' $my_gray%n@%m%{$reset_color%}%'


RPS1='${(e)return_code} $FG[245]%n [%*]%{$reset_color%}%'









# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# hg settings
#ZSH_THEME_HG_PROMPT_PREFIX="$FG[075]($FG[078]"
#ZSH_THEME_HG_PROMPT_CLEAN=""
#ZSH_THEME_HG_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
#ZSH_THEME_HG_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# virtualenv settings
#ZSH_THEME_VIRTUALENV_PREFIX=" $FG[075]["
#ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"





# OLD
#PS1='$FG[237]${(l.$(afmagic_dashes)..-.)}%{$reset_color%}
#$FG[032]%~$(git_prompt_info)$(hg_prompt_info) $FG[105]%(!.#.»)%{$reset_color%} '


# (( $+functions[virtualenv_prompt_info] )) && RPS1+='$(virtualenv_prompt_info)'
# PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
