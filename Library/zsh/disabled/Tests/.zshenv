function q() { exit 0; }
function S() { print -P -- "%S${argv}%s" }
function log---() { local ch=${1:=*}; print -- "${(pl:$COLUMNS::$ch:)}"; }
function log1()
  { printf '%b%-*s%b\n' "\e[1;30;102m" $COLUMNS "> $@ [$?]" '\e[0m'; }
function log!()
  { printf '%b%-*s%b\n\n' "\e[1;30;101m" $COLUMNS "> $@ [$?]" '\e[0m'; }

function e0-fn-update() { env > $zterm/etc/zsh/e0-fn; }



# Test zsh environment
log1 'Exporting variables...'
export ZDOTDIR="/usr/local/Terminal/zsh/Tests"
export ZTERM=/usr/local/Terminal
export FPATH=/usr/local/share/zsh/site-functions:/usr/local/Cellar/zsh/5.8/share/zsh/functions:/usr/local/Terminal/zsh/functions:/usr/local/Terminal/zsh/site-functions:/usr/local/Terminal/zsh/completions:/usr/local/Terminal/zsh/custom
export zterm=$ZTERM
export zdot=$ZDOTDIR
TERM_SESSION_ID=w1t0p0:741E606C-F958-49D2-A177-8855FD22AA0D
SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.PC08RMmLuk/Listeners
LC_TERMINAL_VERSION=3.3.11
COLORFGBG='15;0'
XPC_FLAGS=0x0
LANG=en_CA.UTF-8
PWD=/Users/admin
SHELL=/usr/local/bin/zsh
TERM_PROGRAM_VERSION=3.3.11
TERM_PROGRAM=iTerm.app
PATH=/usr/bin:/bin:/usr/sbin:/sbin
DISPLAY=/private/tmp/com.apple.launchd.j5EtDekpuW/org.macosforge.xquartz:0
LC_TERMINAL=iTerm2
COLORTERM=truecolor
TERM=xterm-256color
HOME=/Users/admin
TMPDIR=/var/folders/ld/lgch2ptj0r393_j_n_2kk_gm0000gn/T/
USER=admin
XPC_SERVICE_NAME=0
LOGNAME=admin
ITERM_SESSION_ID=w1t0p0:741E606C-F958-49D2-A177-8855FD22AA0D
__CF_USER_TEXT_ENCODING=0x1F5:0x0:0x52
OLDPWD=/Users/admin

log1 'Setting aliases...'
alias p='builtin print -P'
alias p-='builtin print -P --'
alias e='builtin echo -'

echo 'Sourcing files...'
source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'

log1 'Loading .oh-my-zsh'
ZSH=$ZDOTDIR/../.oh-my-zsh
source $ZSH/oh-my-zsh.sh


log---
log1 'READY'

trap 'log! "Exiting"' EXIT
