




# Temporary exported variables
function addexp() {
    local id="$1"
    shift
    local value=($@)
    if [[ $# -eq 1 ]]; then
        value="\"$value\""
    else
        value="( ${(@fqqq)value} )"
    fi
    perl -pe "s/# <#Insertion Point: $0#>/export ${id}=${value}    # ${id}: $(datels)\n$&/" \
         -i "$ZDOTDIR/.zmisc"
    green "+ $id"
}
function delexp() {
    local id="$1"
    perl -pe "s/^export ${id}=.*\$//" \
         -i "$ZDOTDIR/.zmisc"
    red "- $id"
}




# Temporary Functions
function addfunc() {
    local id="$1"
    local value=(${@:2})
    perl -pe "s/# <#Insertion Point: $0#>/# ${id}: $(datels)\nfunction ${id}() {\n    ${(j:\n    :)value}\n}\n$&/" \
         -i "$ZDOTDIR/.zmisc"
    green "+ $id"
}
function delfunc() {
    xopen "$ZDOTDIR/.zmisc"
}




# Temporary Aliases
function addalias() {
    local id="$1"
    local value=(${@:2})
    perl -pe "s/# <#Insertion Point: $0#>/alias ${id}=\'${value}\'    # ${id}: $(datels)\n$&/" \
         -i "$ZDOTDIR/.zmisc"
    green "+ $id"
}
function delalias() {
    local id="$1"
    perl -pe "s/^alias ${id}=.*\$//" \
         -i "$ZDOTDIR/.zmisc"
    red "- $id"
}
