#!/bin/zsh

#  zsh-aliases.zsh
#  ~zdot/zsh-aliases.zsh
#
#  Zsh alises.
#  Created by mpuchkov/506:20 on March 27, 2021.


#MARK: - Recently Added
alias -g @-1='1> /dev/null'
alias -g @-2='2> /dev/null'
alias -g @--='&> /dev/null'

alias -g '...'='../..'
alias -g '....'='../../..'
alias -g '.....'='../../../..'
alias -g '......'='../../../../..'

alias lvl='typeset SHLVL'
alias zc='zsh -c'

# Local aliases
alias admin='command ssh -l admin localhost'
alias ubuntu='command ssh -l osboxes ubuntu.vm'
alias mininet='command ssh -l mininet mininet.vm'

alias mod='stat -f "%p"'




#MARK: - Files
# Open zsh configuration files in Xcode.
alias zshenv='open -a Xcode $HOME/.zshenv'
alias zshrc='open -a Xcode $ZDOTDIR/.zshrc'
alias zprofile='open -a Xcode $ZDOTDIR/.zprofile'

alias zalias='open $ZDOTDIR/lib/aliases.zsh'
alias {zhashdir,zdirs}='open $ZDOTDIR/lib/directories.zsh'

alias zlib='open -a Xcode $ZDOTDIR/lib/*'
alias zlibfuncs='open $ZDOTDIR/lib/functions.zsh'
alias zshfuncs='open -a Xcode $ZDOTDIR/{functions,completions}/*'

alias {zshxc,xczsh}='open -a Xcode ~/iCloud/Developer/Projects/Zsh/Zsh.xcodeproj'





#MARK: - Commands
# Command 'cat'
alias {catn,can}='/bin/cat -n'                        #
alias cate='/bin/cat -entv'                           #

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
alias gcm='git commit -m'                             # Commit with message
alias grs='git restore --staged'                      # Restore staged files
alias gpu='git push && git push upstream'             # Push to origin and upstream
alias gtz='() { cd -q $ZDOTDIR && git status; };'     #

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
alias ls='command ls -BFG -hk -%'            #
alias lsA='ls -A -H'                         # All (except ./..; follow links)
alias lsa='ls -a -H'                         # All (follow links)
alias l='ls -l'                      # Long  #
alias {lA,ll}='ls -lA -H'                    # All (except ./..; follow links)
alias {la,al}='ls -la -H'                    # All (follow links)
alias {lsO,lsf}='ls -la -O'                  # All (with file flags)
alias {lsn,lid}='ls -l -n'    # Owner/Group  # Numeric uid, gid
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

# Command 'open'
alias o='open'                                        #
alias app='open -a'                                   #
alias {openr,reveal}='open -R'                        #
alias {opf,pwdo}='open -R $PWD'                       #
alias term1='open -a Terminal'        # Applications  #
alias term2='open -a iTerm'                           #
alias {xe,xopen,openx}='open -a Xcode'                #
alias music='open -a Music'                           #
alias notes='open -a Notes'                           #
alias intellij='open -a "IntelliJ IDEA CE"'           # IntelliJ IDEA
alias vb='open -a VirtualBox'                         #
alias hxf='open -a "Hex Fiend"'                       #

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

# Command 'sudo'
alias sudol='/usr/bin/sudo --login'                   #

# Command 'say'
alias say='command say -v Samantha'                   #
alias alex='command say -v Alex'                      # Default voice

# Command 'tar'
alias tarch='command tar zcvf'                        #???: check

# Command 'xcode-select'
alias xcselect='command xcode-select'                 #

# Installed command 'tealdeer'
alias {tldr,tl}='/usr/local/bin/tealdeer'             #







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
 
# Builtin 'print'
alias p='builtin print'                     #
alias printd='builtin print -P -D'          # Substitute <named dirs> using <~dir>
alias {printl,pl}='builtin print -l'        # Split lines
alias {printn,pn}='builtin print -n'        # No new line
alias pnr='builtin print -nr'               # No new line (ignore \n,\t,etc.)
alias {printp,pp}='builtin print -P'        # Prompt expansion
alias {pc1,print1}='print -nr -C1 --'       # Print in 1 column
alias {pc2,print2}='print -nr -aC2 --'      # Print in 2 columns
alias pb='print -bn'                        # Recognize ^X, \M-X, \C-X

# Builtin 'printf'
alias {beep,bell}='builtin printf "\x07"'   # Bell
alias printq='() { printf "%q\n" "$*"; }'   # Shell quote

# Builtin 'popd'
alias po='builtin popd'                     #

# Builtin 'pushd'
alias pu='builtin pushd'                    #

# Builtin 'exit'
alias quit='builtin exit 0;'                #

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
alias ts='typeset'                          #
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
alias duck='search --duckduckgo'
alias gglimg='search --images'
alias thesaurus='serach --thesaurus'

# Function 'run-help'
alias {help,h}='run-help'

# Function 'order'
alias ord='order -c'

# Function 'show'
alias {s,i}='show'



## Function 'zfn'
#alias fn='zfn'


alias prex='add-zsh-hook preexec'
alias prex-='add-zsh-hook -D preexec'
alias prec='add-zsh-hook precmd'
alias prec-='add-zsh-hook -D precmd'

alias rm-zsh-hook='add-zsh-hook -D'

#MARK: Plugins
alias cfd='cd "$(pfd)"'                      # Change to current Finder directory
