# Put your custom themes in this folder.
# Example:



typeset -H dim_text=$'\C-[[02m'
typeset -H dim_text_bold=$'\C-[[02;01m'

PS1="%{$fg[magenta]%}%~ %{$fg[cyan]%}%(!.#.▪︎)%{$reset_color%} "
RPS1="%(?..%F{red}%?%f) %{$reset_color%}%{$dim_text%}!%!%{$reset_color%}"








#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
##!/bin/zsh
#
##  zTerm
##  oh-my-zsh theme
##
##
##
#
#
# Settings
#typeset reset_color=$'\033[0m'
## primary prompt
##PS1='
##%~ %(!.#.») '
#typeset path_color=$'\033[4;94m'
#typeset mark_color=$'\033[91m'
#
#

#PS1=" %{$path_color%}%~%{$reset_color%}
# %{$mark_color%}%(!.#.▪︎)%{$reset_color%} "
#
#PS2="%{$mark_color%}>%{$reset_color%} "
#PS3=""
#PS4=""
#
#RPS1=""
#RPS2=""
#RPS3=""
#RPS4=""
#
#
#
#
## right prompt
##RPS1='${return_code}'
##RPS1+=' $my_gray%n@%m%{$reset_color%}%'
#
#
#
#
#
#
#
#
## git settings
#ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
#ZSH_THEME_GIT_PROMPT_CLEAN=""
#ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
#
## hg settings
##ZSH_THEME_HG_PROMPT_PREFIX="$FG[075]($FG[078]"
##ZSH_THEME_HG_PROMPT_CLEAN=""
##ZSH_THEME_HG_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
##ZSH_THEME_HG_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
#
## virtualenv settings
##ZSH_THEME_VIRTUALENV_PREFIX=" $FG[075]["
##ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"
#
#
#
#
#
## OLD
##PS1='$FG[237]${(l.$(afmagic_dashes)..-.)}%{$reset_color%}
##$FG[032]%~$(git_prompt_info)$(hg_prompt_info) $FG[105]%(!.#.»)%{$reset_color%} '
#
#
## (( $+functions[virtualenv_prompt_info] )) && RPS1+='$(virtualenv_prompt_info)'
## PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
