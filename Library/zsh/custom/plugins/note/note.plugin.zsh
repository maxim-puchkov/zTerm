# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.



function note() {
    typeset name=$1
    typeset -ag text=("${(@f)argv}")
    mkdir -p ~/etc
    touch ~/etc/note
#    typeset -a line
#    read -t -u0 -A line
    typeset prog="%D{%c} %F{11}%B${0}%b ${1}%f"
    logf $prog
}

