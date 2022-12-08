#!/bin/zsh

#  zsh-aliases.zsh
#  ~zdot/zsh-aliases.zsh
#
#  Zsh alises.
#  Created by mpuchkov/506:20 on March 27, 2021.


# TODOs:
# - Remove MARKs (Xcode Syntax)



# New aliases
alias is='test'         # added by `add-alias` on 2022-08-15 at 21:20:12
alias isset='is -v'     # added by `add-alias` on 2022-08-29 at 21:41:00














# Candy Machine v2
alias candy2='ts-node ~/private/code/metaplex/js/packages/cli/src/candy-machine-v2-cli.ts'
function devnet() {
    typeset cmd="$1"
    shift 1
    typeset DEVNET_KEY="$HOME/.config/solana/devnet.json"
    candy2 "$cmd" -e devnet -k "$DEVNET_KEY" "$@"
}

export DEVNET_PUBKEY="F8w4SHpKo2rsWLe3xPwVssPz5P2uTRpJTt2cNmMbe2d5"
export DEV2_PUBKEY="9XKq42MKEXu4zXf8w5FAhLzbasL6Ng6KREM4PhEegkrG"

# NFT mints
export BALL0="4xVMddJBcERGqVHp6VjBx45tWTp9f1pHVY8espXXbcwd"





#MARK: - Solana
alias so='solana'
alias spl='spl-token'

alias sp='solana program'
alias spd='solana program deploy'

alias gloc='open -a "Google Chrome" "http://localhost:3000/solana"'
alias floc='open -a "Firefox" "http://localhost:3000/solana"'


















#MARK: - Work
# Mainframe
export MAINFRAME=~/mainframe
alias {mf,mainframe}='cd $MAINFRAME'
alias sg='cd $MAINFRAME/code/shotgun-app'
alias times='cd $MAINFRAME/code/timesheet'   # old project with broken database
alias times2='cd $MAINFRAME/code/timesheet2' # current project with correct database
alias venv='source ./venv/bin/activate'
alias django='python3 manage.py'



# My projects
alias {mycode,coded,proj}='cd ~/private/code'     # My code dir 
alias wd='cd -P "$WD"'
alias sniper='cd ~/private/code/sniper'
alias sdl='cd ~/private/code/solanadreamland'









































#MARK: - Files
# Open zsh configuration files in Xcode.
alias zshenv='open -a $CODE_EDITOR $HOME/.zshenv'
alias zshrc='open -a $CODE_EDITOR $ZDOTDIR/.zshrc'
alias zprofile='open -a $CODE_EDITOR $ZDOTDIR/.zprofile'

alias zalias='open -a $CODE_EDITOR $ZDOTDIR/lib/aliases.zsh'
alias {zhashdir,zdirs}='open -a $CODE_EDITOR $ZDOTDIR/lib/directories.zsh'

alias zlib='open -a $CODE_EDITOR $ZDOTDIR/lib/*'
alias zlibfuncs='open $ZDOTDIR/lib/functions.zsh'
alias zshfuncs='open -a $CODE_EDITOR $ZDOTDIR/{functions,completions}/*'

alias {zshxc,xczsh}='open -a $CODE_EDITOR ~/iCloud/Developer/Projects/Zsh/Zsh.xcodeproj'

alias zcode='open -a $CODE_EDITOR $ZDOTDIR'




#MARK: - Commands
# Command 'cat'
alias {catn,can}='/bin/cat -n'                        #
alias cate='/bin/cat -entv'                           #
alias catx='xxd -p'
alias catxx='xxd'

# Command 'chflags'
alias hide='chflags hidden'                           #
alias unhide='chflags nohidden'                       #
alias lock='chflags uchg'                             #
alias unlock='chflags nouchg'                         #

# Command 'chown'
alias {chownl,lnown}='chown -h'                       # Change owner of a symlink
alias chown-some='/usr/sbin/chown -R -H root:wheel'   # Follow symlinks, but not in recursion
alias chown-all='/usr/sbin/chown -R -L root:wheel'    # Follow ALL links

# Command 'chmod'
alias -- {chmodl,lnmod}='/bin/chmod -h'               # Operate on symlinks
alias -- +x='/bin/chmod +x'                           #
alias -- -x='/bin/chmod -x'                           #
alias -- +w='/bin/chmod +w'                           #
alias -- -w='/bin/chmod -w'                           #
alias -- +r='/bin/chmod +r'                           #
alias -- -r='/bin/chmod -r'                           #

# Command 'cp'
alias cp='/bin/cp -i'                                 #
alias cpv='cp -v'                                     #
alias cpdir='cp -R'                                   #

# Command 'du'
alias du='command du -h'                              #
alias du0='du -d0'                                    #
alias du1='du -d1'                                    #

# Command 'find'
alias findl='command find -L'                         #

# Command 'hexdump'
alias hd='command hexdump'                            #

# Command 'head'
alias 1line='command head -n1'                        # First line in file
alias 32bytes='command head -c32'                     # First 32 bytes in file

# Command 'git'
alias gs='git status'                                 # Status
#alias gcm='git commit -m'                             # Commit with message
alias grs='git restore --staged'                      # Restore staged files
alias gpu='git push && git push upstream'             # Push to origin and upstream
alias gtz='() { cd -q $ZDOTDIR && git status; };'     #
alias gc='git checkout'
alias gcm='git checkout master'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gp='git push'
alias gl='git pull'
alias gb='git branch'
alias gq='git checkout master && git pull remote master && git push'
alias gf='git fetch'

# Installed command 'diff'
alias diff='/usr/local/bin/diff --color=always --suppress-common-lines -s -y -P'  #
alias diffl='diff --suppress-common-lines --side-by-side'                         #

# Command 'grep'
alias grep='command grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias grepdir='grep -R -H -n'
alias grepfiles='grep -R -l'
alias grepfiles!='grep -R -L'
#alias gr='grep'                                       #
#alias grepa='grep -E --text --color=always -e ".*"'   #

# Command 'killall'
alias {kall,killl}='command killall'


# Command 'ls'
alias ls='command ls -FG -h -%'              #
alias lsA='ls -A -H'                         # All (except ./..; follow links)
alias lsa='ls -a -H'                         # All (follow links)
alias l='ls -l'                      # Long  #
alias {lA,ll}='ls -lA -H'                    # All (except ./..; follow links)
alias {la,al}='ls -la -H'                    # All (follow links)
alias {lsO,lsf}='ls -la -O'                  # All (with file flags)
alias {lsn,lsid}='ls -l -n'   # Owner/Group  # Numeric uid, gid
alias {lgo,lls}='ls -l -go'                  # No owner/group
alias {lsr,lll}='ls -R'         # Recursive  #
alias {llr,llll}='ls -l -R -H'               #     (long, follow links)
alias {lar,lllll}='ls -lA -R -H'             # All (long, follow links)
alias lsi='ls -ai -H'              # inodes  # All
alias lli='ls -lai -H'                       # All (long)
alias lS='ls -1 -Sr'              # Sort by  # [size]
alias llS='ls -lA -Sr'                       #
alias {lst,lstmod}='ls -1 -tr'               # [time of] modification
alias lstbirth='lst -U'                      #           creation (birth)
alias lstchg='lst -c'                        #           last change
alias lstacc='lst -u'                        #           last access
alias lsc1='ls -1'          # Output Format  # [columns] one entry per line
alias lscv='ls -C'                           #           vertical columns   (↓)
alias lsch='ls -x'                           #           horizontal columns (→)
alias 'ls,'='ls -m'                          # Comma-separated
alias 'ls?'='ls -q'                          # Print non-printable as ?
alias lsattrib='ls -la -Oe@'                 # Extended attributes, ACL, flags
alias {lsd,lld}='ls -ld'                     #
alias lad='ls -lad'                          #
alias lss='command ls -lgo -BFG -Sr'         # Size


# Command 'launchctl'
alias lctl='/bin/launchctl'                           #

# Command 'ln'
alias {lns,sln}='/bin/ln -s'                          # Make symlink
alias lnsf='/bin/ln -Ffs'                             # Overwrite existing symlink

# Command 'unlink'
alias {unl,uln}='/bin/unlink'                         # Unlink

# Command 'mv'
alias mv='/bin/mv -i'                                 #

# Command 'nano'
alias nano='/usr/local/bin/nano --mouse'              #

# Command 'npm'
alias ns='npm start'

# Command 'open'
alias o='open'                                        #
alias app='open -a'                                   #
alias {cdo,openr,opend,reveal}='open -R'              #
alias {openf,opf,pwdo}='open -R $PWD'                 #
alias term1='open -a Terminal'        # Applications  #
alias term2='open -a iTerm'                           #
alias {xe,xopen,openx,ox,opx}='open -a Xcode'         #
alias music='open -a Music'                           #
alias notes='open -a Notes'                           #
alias intellij='open -a "IntelliJ IDEA CE"'           # IntelliJ IDEA
alias vb='open -a VirtualBox'                         #
alias hxf='open -a "Hex Fiend"'                       #
alias {vs,code,vscode}='open -a "Visual Studio Code"' #
alias srctree='open -a Sourcetree'

#???: Command 'xed'
alias .g='xed .gitignore'                    # Files  # .gitignore
alias .ci='xed .gitlab/.gitlab-ci.yml'                # .gitlab.ci-yml

# Installed command 'openssl'
alias openssl='/usr/local/opt/openssl/bin/openssl'    #

# Command 'osascript'
alias osa='osascript -s es'                           # AppleScript object output
alias osah='osascript -s eh'                          # Human-readable output

# Command 'pbcopy'
alias {pbc,cpb}='command pbcopy'                      # Copy to clipboard

# Command 'ps'
alias ps='/bin/ps -o pid,tty,etime,command -h'        #
alias psu='/bin/ps -o pid,tty,user,gid,etime,command' #
alias paw='/bin/ps -aw'                               #
alias psa='/bin/ps -Ahw'

# Command 'rm'
alias rm='/bin/rm -i'                                 #

# Command 'strings'
alias str='command strings'                           #

# Command 'stat'
alias statz='command stat -f "%Z"'                    #
alias mode='command stat -f "%p"'                     #
alias inode='command stat -f "%i"'                    #
alias flags='command stat -f "%f"'                    #

# Command 'sudo'
alias sudol='/usr/bin/sudo --login'                   #

# Command 'say'
alias say='command say -v Samantha'                   #
alias alex='command say -v Alex'                      # Default voice

# Command 'tar'
alias tarch='command tar zcvf'                        #???: check

# Installed command 'tealdeer'
alias {tldr,tl}='/usr/local/bin/tealdeer'             #

# Command 'tail'
alias tf='command tail -f'

# Command 'ts-node'
alias ts='ts-node'

# Command 'xcode-select'
alias xcselect='command xcode-select'                 #

# Command 'yarn'
alias ya='yarn add'
alias ys='yarn start'





#MARK: - Builtins
# Builtin 'autoload'
alias aut='builtin autoload -U'             #
alias autz='builtin autoload -Uz'           #
alias autx='builtin autoload +X'            #
alias autw='builtin autoload -w'            #

# Builtin 'builtin'
alias bltn='builtin'                        #

# Builtin 'bindkey'
alias bk='builtin bindkey'                  #

# Builtin 'exec'
alias re='builtin exec -l ${SHELL:-zsh}'    # Reset shell

# Builtin 'command'
alias cmd='builtin command'                 #

# Builtin 'fc'
alias hist='builtin fc -l'                  # List events
alias histall='builtin fc -l 1-'            # List all events
alias histlast='builtin fc -l -10'          # List last 10 events

# Builtin 'functions'
alias fns='builtin functions'               #
alias list-functions='builtin functions +'  #
alias 'ftrace-'='builtin functions +T'      # -: turn off trace
alias ftrace='builtin functions -T'         #  : turn on trace
alias 'ftrace+'='builtin functions -t'      # +: turn on trace (extended)
alias -- +t='functions +T'                 ## +t: turn off trace
alias -- -t='functions -T'                  # -t: turn on trace
alias -- -T='functions -t'                  # -T: turn on trace (extended)

# Builtin 'echo'
alias e='builtin echo -'                    #

# Builtin 'exit'
alias quit='builtin exit 0;'                #
 
# Builtin 'print'
alias p='builtin print'                     #
alias printd='builtin print -P -D'          # Substitute <named dirs> using <~dir>
alias {printl,pl}='builtin print -l'        # Split lines
alias {printn,pn}='builtin print -n'        # No new line
alias pnr='builtin print -nr'               # No new line (ignore \n,\t,etc.)
alias {printp,pp}='builtin print -P'        # Prompt expansion
alias {pc1,print1}='print -nr -C1 --'       # Print in 1 column
alias {pc2,print2}='print -nr -aC2 --'      # Print in 2 columns
#alias pb='print -bn'                        # Recognize ^X, \M-X, \C-X

# Builtin 'printf'
alias {beep,bell}='builtin printf "\x07"'   # Bell
alias printq='() { printf "%q\n" "$*"; }'   # Shell quote
alias pf='printf'

# Builtin 'popd'
alias po='builtin popd'                     #

# Builtin 'pushd'
alias pu='builtin pushd'                    #

# Builtin 'strftime'
alias strf='builtin strftime'               #
alias date-='strftime "%F"'                 # Date-       2020-10-11
alias ldate='strftime "%B %f, %Y"'          # Long        October 11, 2020
alias dateat='strftime "%F at %T"'          # Y-m-d at T  2020-10-11 at 23:59:59
alias atdate='strftime "%v at %T"'          # d-M-Y at T  11-Oct-2020 at 23:59:59
alias logdate='strftime "%b %d %T"'         # Log         Oct 11 23:59:59

# Builtin 'type'
alias types='builtin type -a'               # Print all command types

# Builtin 'typeset'
#alias ts='typeset'                          #
alias tsm='noglob typeset -m'               #
alias tsp='typeset -p'                      # Output in form of calls to typeset
alias tspm='noglob typeset -p -m'           #   (all matches)
alias global='typeset -g'                   #
alias {Assoc,Asc}='typeset -A'    # Arrays  #
alias {array,Arr}='typeset -a'              #
alias Float='typeset -F'         # Numbers  # Float (fixed,4)       123.45:  123.4500
alias EFloat='typeset -E'                   # Float (engineering,4) 123.45:  1.235e+02
alias Int='typeset -i'                      # Integer               123.45:  123

# Builtin 'unalias'
alias una='builtin unalias'                 #

# Builtin 'unset'
alias uns='builtin unset'                   #
alias unf='builtin unset -f'                #

# Builtin 'vared'
alias v='builtin vared'                     #
alias v+='builtin vared -c -p "value: "'    #

# Builtin 'which'
alias wh='builtin which'                    #
alias wha='builtin which -a'                # Print all occurrences in path

# Builtin 'zparseopts'
alias zopts='zparseopts -D -E -F -K -M -A opts -'







#MARK: - Functions
# Function 'compdef'
alias cdef='compdef'

# Function 'search'
alias srch='search'
alias define='search --dictionary'
alias ggl='search --google'
alias gglimg='search --images'
alias duck='search --duckduckgo'
alias translate='search --translate'
alias thesaurus='serach --thesaurus'

# Function 'run-help'
alias {help,h}='run-help'

# Function 'order'
alias ord='order -c'

# Function 'show'
alias {s,i}='show'

# Function 'fn'


# Function 'add-zsh-hook'
alias prex='add-zsh-hook preexec'
alias prex-='add-zsh-hook -D preexec'
alias prec='add-zsh-hook precmd'
alias prec-='add-zsh-hook -D precmd'

alias rm-zsh-hook='add-zsh-hook -D'

#MARK: Plugins
alias cfd='cd "$(pfd)"'                      # Change to current Finder directory



#MARK: - Global
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g '.....'='../../../..'
alias -g '......'='../../../../..'

alias -g @-1='1> /dev/null'
alias -g @-2='2> /dev/null'
alias -g @--='&> /dev/null'


alias -g @dev='-e devnet -k ~/.config/solana/devnet.json'






# Misc
alias pb='open -a Safari https://www.chess.com/puzzles/battle'

alias docs='open ~/Documents'
alias goopter-dev='ssh -p 10022 -i ~/.ssh/key/goopter-maxim.pem maxim@dev.goopter.com'

alias p2='command python2'
alias p3='command python3'

alias pxd='echo "${$(xcode-document):h}"'   # print xcode file directory
alias cxd='cd "${$(xcode-document):h}"'     # change to xcode file directory

alias lvl='typeset SHLVL'
alias zc='zsh -c'


# Local aliases
alias admin='command ssh -Y -l admin localhost'
alias ubuntu='command ssh -Y -l osboxes ubuntu.vm'
alias mininet='command ssh -Y -l mininet mininet.vm'



alias ports="netstat -anvp tcp | awk 'NR<3 || /LISTEN/'"
alias {psports,portsps}="ports | awk '/[[:digit:]]+/ {print \$9}' | sort | ips"


# ips - "input ps"
#   Usage: `ips <pid>` or `echo <pid> | ips`
function ips() {
    emulate -L zsh
    autoload -Uz error
    if [[ ! -t 0 ]]; then
		set -- "$@" "${(f)$(<&0)}"
	fi
    [[ $# -gt 0 ]] || error -1 -u "'$0 <pid>' or 'echo <pid> | $0'" 'not enough arguments'
    command ps -o pid,tty,etime,command -h '-p '${^@}
}

function len() {
    printf '%d\n' "${(c)#*}"
}
function len2() {
    echo $(( $(len "$@") * 2 ))
}


#MARK: - Solana functions
# Link a different private-key for 'sniper'.
# Defaults to devnet wallet.
function pk() {
    builtin cd -q ~/private/code/sniper/config
    typeset key_number="$1"
    
    typeset key_file
    case $key_number in
        "0") key_file=""
             echo "Removing private key file"
        ;;
        "2") key_file="private-key.dev2" ;;
        *)   key_file="private-key.devnet" ;;
    esac
    
    typeset key_symlink="private-key"
    command unlink "$key_symlink"
    if [[ -n "$key_file" ]]; then
        command ln -s "$key_file" "$key_symlink"
    fi
    print-link "$key_symlink"
}

# Solana 'Hello world' program
export SOL_HELLO=~/private/code/example-helloworld
function redeploy() (
    builtin cd -q $SOL_HELLO
    solana program deploy dist/program/helloworld.so
)

# Open solana explorer
function soex() {
    typeset query="$1"
    typeset url="https://explorer.solana.com/address/${query}?cluster=devnet"
    open "$url"
}
































alias corrupt='flip-bit.py'

alias bytes='stat -f "%z"'
function filesize {
    # printf "%s: %i bytes\n" "$1" $(stat -f "%z" $1)
    command stat -f '%N: %z bytes' $1
}
function bits {
    [[ -e $1 ]] || error -1 'file does not exist: ${1}'
    printf '%i\n' $(( `bytes $1` * 8 ))
}

alias decompile='objdump -d' # *disassemble
alias decompile-all='objdump -D'

function hg {
    history 0 | grep "$@"    
}



function test-dd {
    typeset DEV_FILE=$1
    [[ -e /dev/$DEV_FILE ]] || error -1 'dev file not found: ${DEV_FILE}'
    dd if=/dev/$DEV_FILE of=./$DEV_FILE bs=1024 count=1 conv=notrunc #2>/dev/null
    xxd -p ./$DEV_FILE
}









## Recently Added Aliases ##
alias sdo='sudo'    # added by `add-alias` on 2022-12-08 at 14:33:08
alias touchp='pbfile'    # added by `add-alias` on 2022-12-06 at 16:12:14
alias gif='app licecap'    # added by `add-alias` on 2022-10-17 at 18:12:18
alias dotar='tar xvzf'    # added by `add-alias` on 2022-10-15 at 00:21:23
alias untar='tar xvzf'    # added by `add-alias` on 2022-10-02 at 20:37:18
alias pyg='pygmentize'    # added by `add-alias` on 2022-09-06 at 15:01:06
alias m='man'    # added by `add-alias` on 2022-08-31 at 17:26:56
alias xxp='xxd -p'    # added by `add-alias` on 2022-08-30 at 20:41:14
alias utmpx='cat /var/run/utmpx'    # added by `add-alias` on 2022-08-30 at 20:40:51
alias rand='python3 -c "import random; print(random.randint(1, 100))"'    # added by `add-alias` on 2022-08-29 at 21:29:11
alias mksh='mkzsh -sx'    # added by `add-alias` on 2022-08-27 at 17:57:28
alias pr='open -a Safari "https://www.chess.com/puzzles/rush"'    # added by `add-alias` on 2022-08-27 at 10:53:29
alias hello='printf "Hello, World!\n"'    # added by `add-alias` on 2022-08-27 at 10:44:10
alias python='python3'    # added by `add-alias` on 2022-08-26 at 12:41:28
alias cra='clear-recent-apps'    # added by add-alias on 2022-08-16 at 12:22:59


# Add alias to the 'zalias' file.
function add-alias {
  local name value comment
  [[ -n $1 ]] && name=$1  || vared -p "alias name: "  name
  [[ -n $2 ]] && value=$2 || vared -p "alias value: " value
  [[ -n $3 ]] && comment=$3 || comment="added by \`$0\` on $(strftime '%F at %T')"
  local FILE=$ZDOTDIR/lib/aliases.zsh
  local TMP=/tmp/aliases.zsh
  rsync -a $FILE $TMP
  local quoted_value=${(qq)value//\"/\\\"}
  awk '//; /^## Recently Added Aliases ##/ {print "alias '$name'='${quoted_value}'    # '$comment'"}' $TMP > $FILE
  if [[ $? -ne 0 ]]; then
    printf 'Error adding alias. Restoring file: %s\n' "$FILE"
    rsync -a $TMP $FILE
  else
    printf 'Alias added successfully: %s=%s\n' "$name" "$quoted_value"
  fi
  source $FILE
}
