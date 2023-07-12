#
#
#
#
#


###  User's Documents  ###
# Library
hash -d AppSupport="$HOME/Library/Application Support"
hash -d Libraries="$HOME/Library/Script Libraries"
hash -d Scripts="$HOME/Library/Scripts"
hash -d Services="$HOME/Library/Services"
hash -d Workflows="$HOME/Library/Workflows"

# iCloud
hash -d iCloud="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
hash -d sfu=~iCloud/SFU
hash -d dev=~iCloud/"Developer"
hash -d proj=~iCloud/"Developer/Projects"

hash -d Desk="$HOME/Desktop"
hash -d Docs="$HOME/Documents"
hash -d work="$HOME/Documents/Work"

# Shared
hash -d Shared="/Users/Shared"
hash -d iterm2=~Shared/"iTerm2"
hash -d bak=~Shared/"Backups"

# Private
hash -d select="$HOME/private/var/select"



###  Z-Shell  ###
hash -d zdot="$ZDOTDIR"
hash -d zfunctions="$ZDOTDIR/functions"
hash -d zcompletions="$ZDOTDIR/completions"
hash -d zlib="$ZDOTDIR/lib"
hash -d zetc="$ZDOTDIR/etc"
hash -d zprofiles=~zetc/"profiles"

# Oh-my-zsh
hash -d omz="$ZSH"
hash -d custom="$ZSH_CUSTOM"

# Other zsh
hash -d "zsh-${ZSH_VERSION}"="/usr/share/zsh/$ZSH_VERSION"
hash -d zterm1="/Users/Shared/Developer/Frameworks/zTerm.framework/Versions/Current"
hash -d zterm2=~proj/zTerm2
