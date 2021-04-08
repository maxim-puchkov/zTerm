#  iterm2
#  plugins/iterm2
#
#  Custom oh-my-zsh plugin.
#  Created on March 20, 2021.



# Docs: https://iterm2.com/python-api/
typeset ITERM2_APP_SUPPORT="$HOME/Library/Application Support/iTerm2"
typeset ITERM2_SHARE="/usr/local/share/iterm2"


#MARK: - Functions
# iterm2-edit: edit iTerm scripts in Xcode.
function iterm2-edit {
  local -a files=()
  local iterm_scripts_dir="$HOME/Library/Application Support/iTerm2/Scripts"
  local name
  for name; do
    file="$iterm_scripts_dir/${${name:t}%.py}.py"
    files+="$file"
  done
  command open -a Xcode -- $files
}

### Other Functions ###
function iterm2_notify {
  printf '\e]9;%s\a' "$@"
}
function iterm2_bounce {
  printf '\e]1337;RequestAttention=yes\a'
}
function iterm2_badge {
  printf '\e]1337;SetBadgeFormat=%s\a' $(echo "$@" | command base64)
}


#MARK: - Aliases
alias it2r='it2run'
alias it2prof='typeset -p1 ITERM_PROFILE'
alias it2cd='cd $ITERM2_APP_SUPPORT'

alias it2dynamic='open -a Xcode "/Users/Shared/iTerm2/Dynamic Profiles/"*'
alias it2scripts='open -a Xcode $ITERM2_APP_SUPPORT/Scripts/**/*.py'

alias it2w='echo "$ITERM_PROFILE (${COLUMNS}x${LINES})"'
alias 2r='it2run'
alias it2func='it2run call_function'

#"$ITERM2/iterm2env/versions/3.8.6/bin/python3"

compdef '_arguments "*:*:( $HOME/Library/Application\ Support/iTerm2/Scripts/*.py(:t) )"' it2run
