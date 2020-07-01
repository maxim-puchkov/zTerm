# User-specific profile for interactive zsh(1) shells.


#MARK: - Z-Terminal
function txtf() {
    typeset txtf_file="${zterm}/etc/${0}"
    typeset -A txtf_list
    readfile lines <$txtf_file
    
#    set -A txtf_list
    
    while [[ -n $1 ]]; do
        case $1 in
            -e) ${=EDITOR} $txtf_file ;;
            *)
        esac
        shift
    done
    
    typeset -A text_files;
    text_files=(
        [lf]=~/var/files/linesf
        [tf]=~/var/files/textf
        [pf]=~/var/files/patternsf
        [lbf]=/usr/local/Terminal/etc/labels
    )
        
    builtin print -- $text_files[
}
export lf=$F[lf]
export tf=$F[tf];
export pf=$F[pf]
export lbf=$F[lbf]



# Open Z-Terminal Xcode project.
function xct()      { open -a Xcode "$zterm/Terminal.xcodeproj" }
alias zxc='xct'
# Open Services Xcode project.
function xcs()      { open -a Xcode "$zterm/Services.xcodeproj" }
# zshenv - zsh environment for all shells.
function zenv()     { open -a Xcode "$ZSHENV" }
# zprofile - profile for zsh shells.
function zprofile() { open -a Xcode "$ZPROFILE" }
# zshrc - configuration file for zsh shells.
function zrc()      { open -a Xcode "$ZSHRC" }
# zio - input/output display configuration.
function zio()      { open -a Xcode "$ZIO" }
# zalias - zsh aliases.
function zalias()   { open -a Xcode "$ZALIAS" }
# zexport - zsh exported environment variables.
function zexport()  { open -a Xcode "$ZEXPORT" }
function zutil()    { open -a Xcode "$ZUTIL" }
# znet - zsh network configuration.
function znet()     { open -a Xcode "$ZNET" }
# zmisc - miscellaneous zsh additions.
function zmisc()    { open -a Xcode "$ZMISC" }
# zcomp - zsh completion functions.
function zcomp()    { open -a Xcode "$ZCOMP" }

function zload()    { open -a Xcode "$ZDOTDIR/.zload" }




function xexpn() {
    typeset expansion=$argv
    S "$expansion"
    while read param; do
        print ${param:t}
    done <&0
}
function xxargs() {
    set +A $argv[6] 1 2 3 4
    xargs ${=argv}
    typeset command=$argv
    while read arg; do
        ($command $arg)
    done <&0
    
}






#MARK: - Text Patterns
function file_lines() {
    local line_prefix=$1
    local line_suffix=$2
    readfile lines <&0
    print -l ${line_prefix}${^lines}${line_suffix}
    return 0
}
function cmds() {
cat <<'EOF'
"perl -p -e 's/^[\h\v]+//g;  s/[\h\v]+$/\n/g'"
"awk '/^[[:space:]]\$/ { sub(/^[[:space:]]+//); print; }'"
"sed -E -n -e 'p'"
EOF
}
function lines() {
    typeset -ag ${1:-lines}
    print -v ${1:-lines} -l -- ${(fq)"$(cat <<'EOF'
perl -p -e 's/^[\h\v]+//g;  s/[\h\v]+$/\n/g'
awk '/^[[:space:]]\$/ { sub(/^[[:space:]]+//); print; }'
sed -E -n -e 'p'
EOF
    )"}
}
function call() {
    set -- $argv
    $argv
}
function wsr() {
    only_matching='/./'
    typeset -ag list
    list=(${(@fqqqq)"$(cat <<'EOF'
perl -p -e 's/^[\h\v]+//g;  s/[\h\v]+$/\n/g'
awk '/./ { sub(/^[[:blank:]]+/, ""); print; }'
sed -E -n -e 'p'
EOF
    )"})
    () {
        input_file=$1
        while [[ -n $1 ]]; do
            cmd=(${(Q)1})
            print_h1 "Program: ${cmd[1]}"
            ${(z)cmd} <$input_file
            redbg $=cmd
            shift
        done
    } =(<&0) ${list}
    return 0
}



typeset -ix current_id=0
function Beg() {
    print -P -- "Begin %F{2}${current_id}%f"
    print -P -- "%B%F{1}<%f%b"
    let current_id=$current_id+1
}
function End() {
    print -P -- "%B%F{1}>%f%b"
    print -P -- "End %F{1}${current_id}%f\n"
    let current_id=$current_id-1
}


function add_tests() {
    # Compdef test function.
    function foo() {
        printf '%s\n' "$(magenta 'Function' ${0})"
        printf 'Defined in %s\n' "$ZPROFILE"
    }

    # Compdef test function.
    function bar() {
        printf '%s\n' "$(magenta 'Function' ${0})"
        printf 'Defined in %s\n' "$ZPROFILE"
    }




    #MARK: - Predefined Test Variables
    l1=( 'a' 'b' 'c' 'x' 'y' 'z' )
    l2=( '1' '2' '3' )
    l3=( {a..z} )
    l4=( 'word' 'word abc' 'abc word' 'word abc word' )
    l5=( '/path/to/a' '/path/to/b' '/c' 'c/d' )
    l6=( 'Bob' 'Alice' 'Bob' 'Charlie' 'Bob' 'Bob' 'Charlie' 'Alice' )

    typeset -Ag Arr
    Arr=(
        [name]='Jane'
        [surname]='Doe'
        [variable]='Arr'
        [message]='Hello, world!'
        [home]=~
        [dir]="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
    )


    typeset -Ag Assoc
    Assoc=(
        'message'   'Hello, world!'
        'name'      'Bob'
        'age'       50
        'home'      ~
        'cmpt473'   ~/iCloud/SFU/10-*/473/assignments
        'phil310'   ~/iCloud/SFU/10-*/PHIL\ 310/assignments
    )

    typeset -Ag A1
    A1=($(print -C2 {1..26} {A..Z}))

    typeset -Ag A2
    A2=( key1 val1 key2 val2 X-key3 val3 key4 X-val4 )




    # 10-second long job.
    function job10() {
        local tmpf=$(tempfile)
        printf 'Job 10 (%s) started on %s.\n' "$0" "$(date)" &>> $tmpf
        print-line &>> $tmpf
        local end=$(( $SECONDS + 10 ))
        while [[ $SECONDS -lt $end ]]; do
            printf '%s.\tRunning job #%s.\n' "$(date -j +'%T')" "$0" &>> $tmpf
            sleep 1
        done
        print-line &>> $tmpf
        printf 'Job 10 (%s) completed on %s.\n' "$0" "$(date)" &>> $tmpf
        printf '%s\n' "$(< $tmpf)"
        printf 'Printed %s characters to %s.\n' ${$(wc -c $tmpf)[1]} "$tmpf"
        rm $tmpf
        local exitcode=$?
        printf 'Exit %s.\n' $exitcode
        return $exitcode
    }
}
