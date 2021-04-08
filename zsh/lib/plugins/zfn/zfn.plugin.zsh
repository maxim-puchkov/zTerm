#!/bin/zsh

#  zfn
#  functions
#
#  Create and edit zsh autoload functions.
#  Created on March 19, 2021.


typeset _ZFN_AWK_DIR="${0:h}/AWK"
[[ ! -d $_ZFN_AWK_DIR ]] && return 1


function zfn {
# zfn
#
# Create, edit, show, generate completion, etc.
# for zsh autoload functions.
#
# Usage:
#   zfn [ -Z dir ] [ -d dir ] [ -[iow] ] <command> name [args...]

# Commands:
#   Create a new function:    make, makecomp
#   Print function source:    show, print
#   Display function:         where, open, trace
#   Generate completion:      tags, complete, help
#   Other commands:           rename, isdef, isrec
emulate -L zsh
setopt extendedglob

autoload -U error pipeset # ztemplate





#MARK: - Function options
# @define option
# @define command   1
# @define arg       *: :( $ZDOTDIR/{functions,completions}{,/**/*}(:t) ${(k)functions} )
#
# @option       -d <dir>
# +description  Set function subdirectory relative to the root directory.
# +completion   :subdir:( $ZDOTDIR/{functions,completions}/**(/\:t) )
#
# @option       -w
# +description  Write 'ztemplate' files to output path.
#
# @option       -o
# +description  Open function source file if it exists or will be created.
#
# @option       -i
# +description  Ignore cached tag files.
local -A opts
local -a specs=('d:' 'w' 'o' 'i')
if ! zparseopts -D -F -K -M -A opts - ${specs[@]} \
     2> >(error -I -d: -f3-); then
  return 1
fi





# ZFN tags cache directory.
local zfn_cache_dir="$ZSH_CACHE_DIR/zfn"

# ZFN AWK scripts directory.
#local _ZFN_AWK_DIR="$ZSH/functions/.zfn"

# ZFN function directories.
local functions_dir="$ZSH/functions"
local completions_dir="$ZSH/completions"

# ZFN function log file.
local zfn_log_file="$ZSH/log/functions.log"





# ZFN AWK environment.
export      ZFN_DELIMITER=':%:'
export -aUT ZFN_METACHARS metachars=('@' '+')
export -aUT ZFN_TAGWORDS  tagwords=('description' 'completion')


## ZTEMPLATE options and text macros.
#local -A zt_options
#local -A zt_macros
#zt_macros=(
#  [--generator]="'${0%%_*}'"
#  [--project]="zTerm@${PROG} (id: ___TEMPLATE_ID___)"
#)
#local -a zt_templates









#MARK: - Exit Trap
# Unset all zfn functions and
# exported variables on exit.
function __zfn_exit() {
  {
    unset -f -m -- "(__)#${${0##_#}%%_*}_*"
    unset -m -- "${${(U)0##_#}%%_*}_*"
  } 2>/dev/null
}
trap '__zfn_exit' EXIT









#MARK: - Private Functions
# Warn that new files are not written to the
# output path unless '-w' option is set.
function __zfn_require_write_permission() {
  local option_name='-w'
  printf "$fg[4]%s$fg[-]: cannot make functcion '$fg[1]%s$fg[-]' if option '$fg[4]%s$fg[-]' is not set\n" \
         "$PROG" "$function_name" "$option_name" >&2
}

# Print message from 'zfn' function.
function __zfn_print() {
  print -P -r -- "%F{blue}${PROG}%f: ${argv}"
}

# Log date and time when an autoload or completion function is created.
function __zfn_write_log() {
  builtin strftime "%v at %T%t${argv}" >>$zfn_log_file
}


# @command      log
# +description  Read functions.log.
function zfn_log() {
  less "$zfn_log_file"
}

## @command mv
## +description  Move function to another function subdirectory.
#function zfn_mv() {
#  echo $function_name
#  echo $function_file
#  local old_path="${function_file:A}"
#  local new_path="${old_path/}"
#
#
#  yellow-bg $old_path
#  blue-bg $functions_dir
#  if [[ "$old_path" =~ "${functions_dir:A}" ]]; then
#    green Yes
#
#  else
#    red No
#  fi
#  blue "$old_path" '=~' "${functions_dir:A}"
#}







#MARK: Completion Functions
# @command      tags
# +description  Parse function source file to generate completion tags.
function zfn_tags() {
  # Outputs:
  #:  @define[ ]@option[ ]
  #:  @option[ ]-o[ ]description[ ]completion[ ]
  #:  ...
  # Delimiter is shown with [ ].
  local cache_file="${zfn_cache_dir}/${function_name}.cache"
  #TODO: - ???
  if [[ ${+opts[-i]} -eq 1 ]] &&
     [[ $function_file -nt $cache_file ]]; then
    print -u2 -- "CACHE NEEDS UPDATE"
  fi
  if [[ -z "$function_file" ]]; then 
    error -1 -m 'function file for ${function_name} not found'
  fi
  local awk_program="$_ZFN_AWK_DIR/${0#*_}.awk"
  /usr/bin/awk "$@"                   \
      -f "$awk_program"               \
      -v v_prefix="${function_name}_" \
      $function_file                  |
  /usr/bin/tee "$cache_file"
  
  #TODO: - Cache output
}


# @command      complete
# +description  Parse completion tags to generate completion function.
function zfn_complete() {
  # Pipe 'tags' into 'complete' to generate completion function.
  # Outputs:
  #:  _arguments '(-o --option)'{-o,--option}'[desc]action' 'n: :->cmd'...
  #:  case $state in (cmd) local -a cmds=(...); _describe -t cmds 'cmd' cmds;;... esac
  #:  ...
  local awk_program="$_ZFN_AWK_DIR/${0#*_}.awk"
  zfn tags "$function_name" |
  /usr/bin/awk "$@"         \
      -f "$awk_program"
}


# @command      help
# +description  Parse completion tags to list available function commands.
function zfn_help() {
  local awk_program="$_ZFN_AWK_DIR/${0#*_}.awk"
  zfn tags "$function_name" |
  /usr/bin/awk              \
      -F "$ZFN_DELIMITER"   \
      -f "$program"
  #TODO: - Set 'options' and 'commands' arrays
  
  #TODO: - Print function options and commands
}









#MARK: - Display Functions
# @command      isdef
# +description  Check if autoload function is defined (loaded).
function zfn_isdef() {
  set -- $function_name $argv
  local reply name
  local -i return_code=0
  for name; do
    if [[ ${+functions[$name]} -eq 0 ]]; then
      # Not function (2).
      reply="$fg[1]not a function"
      let return_code=2
    else
      # Function, check if defined.
      builtin functions $function_name                        |
      /usr/bin/sed -n -e '/^[[:blank:]]*# undefined$/{n; p;}' |
      /usr/bin/grep -F -q -e 'builtin autoload -X'
      
      if [[ $? -eq 0 ]]; then
        # Function, not defined (1).
        reply="an $fg[3]undefined autoload function"
        let return_code=1
      else
        # Function, defined (0).
        reply="a $fg[2]defined function"
        let return_code=0
      fi
    fi
    
    # Print reply message.
    if [[ "$cmd_name" == "${0##${PROG}_}" ]]; then
      printf "$fg[4]%s$fg[-]: %s is %s$fg[–]\n" \
             "$PROG" "$name" "$reply"
    fi
  done
  return $return_code
}


# @command      isrec
# +description  Check if the function is called recursively.
function zfn_isrec() {
  local -i call_count
  let call_count="${(M)#funcstack:#$function_name}"
  return "$call_count == 0"
}


# @command      open
# +description  Open function source file in Xcode.
function zfn_open() {
  /usr/bin/open -a Xcode -- ${matching_files[@]}
  return $?
}


# @command      where
# +description  Print location of the source file.
function zfn_where() {
  local file
  for file in ${matching_files[@]}; do
    if [[ ! -p /dev/stdout ]] &&
       [[ -t 1 ]]; then
      printf "$fg[6]%s$fg[-]: " "${file:t}"
    fi
    printf '%s\n' "$file"
  done
  return 0
}


# @command      cd
# +description  Change working directory to function directory.
function zfn_cd() {
  # Directory of the specified function.
  local function_dir="${function_file:a:h}"
  # If function directory is empty,
  # go to root functions directory.
  if [[ -z "$function_dir" ]]; then
    function_dir="$functions_dir"
  fi
  
  if [[ "$PWD" == "$function_dir" ]]; then
    error -1 -m 'already in function directory: ${PWD}'
  fi
  cd -- "$function_dir"
  return $?
}


# @command      trace
# +description  Trace function execution.
function zfn_trace() {
  builtin functions -T $function_name
  printf "$fg[1]Trace$fg[-]: function '%s' with arguments $fx[underline]'%s'$fx[no-underline]\n" \
         "$function_name" "$argv"
  # Call function with arguments.
  $function_name "$@"
  builtin functions +T $function_name
  return 0
}


# @command      print
# +description  Print function.
function zfn_print() {
  # @option       -c,--color
  # +description  Print colorized output.
  # @option       -f,--function
  # +description  Print function definition.
  # @option       -s,--source
  # +description  Print function source file.
  # @option       -b,--body
  # +description  Print function body only.
  # Print options.
  local -A print_opts
  local -a specs=(
    '-color'    '-source'    '-body'    '-function'
    'c=-color'  's=-source'  'b=-body'  'f=-function'
  )
  if ! zparseopts -D -E -F -K -M -A print_opts - ${specs[@]} \
       2> >(error -I -f3 -d:); then
    return 1
  fi
  # For all matching function files.
  local file
  for file in ${matching_files[@]}; do
    {
      case 1 in
        # Print only the function body.
        $+print_opts[--body])
          if [[ $file =~ '[.][a-z]*sh' ]]; then
            file=${file%%.*}
          fi
          builtin functions -- "${file:t}" |
          command sed -e '1d;$d;'
        ;;
        # Print function ...() { ... }.
        $+print_opts[--function])
          if [[ $file =~ '[.][a-z]*sh' ]]; then
            file=${file%%.*}
          fi
          builtin functions -- "${file:t}"
        ;;
        # Print contents of source file.
        $+print_opts[--source]) ;&
        *)
          command cat -- "$file"
        ;;
      esac
    } | {
      if [[ ${+print_opts[--color]} -eq 1 ]]; then
        highlight
      else
        $NULLCMD
      fi
    }
  done
}


# @command       show
# +description   Print function source code with syntax highlighting.
function zfn_show() {
  local file
  for file in $matching_files; do
    highlight $file 2>/dev/null
  done
  return $?
}







#MARK: - Make Functions
# @command      make
# +description  Make a new autoload function.
function zfn_make() {
  # Create a new 'ztemplate' file.
  #  zt_templates=('zsh' 'file-header' 'function-header' 'zfn-tags' 'options')
  #  ztemplate ${(kv)zt_options[@]} ${(kv)zt_macros[@]} make '-'${^zt_templates[@]}

  command cat <<EOF >$out_path
#!/bin/zsh

#  ${out_path:t}
#  ${out_path}


emulate -L zsh

local -A opts
local -a specs=( '-opt:' 'o:=-opt'  '-flag' 'f=-flag' )
if ! zparseopts -D -F -K -M -A opts - \${specs[@]} \\
     2> >(error -I -d: -f3-); then
  return 1
fi

# ...

EOF
  
  if [[ -e $out_path ]]; then
    # Print success message.
    printf "Autoload function created: $fg[2]%s$fg[-]\n" "$out_path"
    # Log created function.
    __zfn_write_log "$out_path"
    
    # Open file if '-o' is set.
    if [[ ${+opts[-o]} -eq 1 ]]; then
      /usr/bin/open -a Xcode -- $out_path
    fi
    return 0
  else
    return 1
  fi
}


# @command      makecomp
# +description  Make a new completion function.
function zfn_makecomp() {
  #zt_templates=('compdef' 'file-header' 'zfn-complete')
  #ztemplate ${(kv)zt_options[@]} ${(kv)zt_macros[@]} make '-'${^zt_templates[@]}
  
  #TODO: make completion function without `ztemplate'
  #  eval $( zfn complete ${0#_} )
  
  if [[ -e $out_path ]]; then
    # Print success message.
    printf "Completion function created: $fg[2]%s$fg[-]\n" "$out_path"
    # Log created function.
    __zfn_write_log "$out_path"
    
    # Open file if '-o' is set.
    if [[ ${+opts[-o]} -eq 1 ]]; then
      /usr/bin/open -a Xcode -- $out_path
    fi
    return 0
  else
    return 1
  fi
}




#MARK: - New Functions
# @command       src
# +description   Print path of function's source file.
function zfn_src() {
  local source_file="${functions_source[$function_name]}"
  if [[ ${+functions[$function_name]} -eq 0 ]]; then
    error -1 -m 'not a func'
  fi
  
  if [[ -e "$source_file" ]]; then
    printf '%s\n' "$source_file"
  else
    error -1 -m 'source file of ${function_name} not found'
  fi
}





#MARK: - Old Disabled Functions
## @command      rename
## +description  Rename a function.
#function zfn_rename() {
#  # Get new name.
#  local new_name=$1
#  if [[ -z "$new_name" ]]; then
#    error -1 -m 'new function name is not specified'
#  fi
#  # Set old and new file names.
#  local renamed
#  if [[ ! -f "$function_file" ]]; then
#    error -1 -m 'cannot rename ${function_name} - source file not found'
#  fi
#  renamed="${function_file:h}/${new_name}"
#
#  # Rename function file and replace all occurrences
#  # of previous name with new function name.
#  command mv -i -- $function_file $renamed                                       &&
#  command sed -I "" -e "s/${function_file:t}/${renamed:t}/" -- $renamed          &&
#  printf "$fg[4]%s$fg[-]: Function renamed: $fg[1]%s$fg[-] --> $fg[2]%s$fg[-]\n" \
#         "$PROG" "${function_file:t}" "${renamed:t}"                             &&
#  __zfn_write_log "${function_file} --> ${renamed:t}"
#
#  # Open file if '-o' is set.
#  if [[ ${+opts[-o]} -eq 1 ]]; then
#    /usr/bin/open -a Xcode -- $renamed
#  fi
#  return 0
#}















#MARK: - ZFN Main Program
typeset PROG="${${0##*/}%%.*}"


# If needed, create necessary directories:
# functions, completions, and cache.
local -a required_dirs=( $functions_dir $completions_dir $zfn_cache_dir )
local dir
for dir in ${required_dirs[@]}; do
  if [[ ! -d $dir ]]; then
    if command mkdir "$dir"; then
      __zfn_print "directory created: %U${dir}%u"
    else
      error -2 -m 'failed to create directory: ${dir}'
    fi
  fi
done









#MARK: Positional Arguments
if [[ $# -eq 0 ]]; then
  error -1 -m 'not enough arguments'
fi

# Set ZFN command name ($1).
local cmd_name=$1
if [[ -z "$cmd_name" ]]; then
  error -1 -m 'no command'
fi

# Set function name ($2).
local function_name="${${2=}##*/}"

shift 2




# Full name of ZFN command function.
typeset CMD="${PROG}_${cmd_name}"

if [[ ${+functions[$CMD]} -eq 0 ]]; then
  error -127 -m '${cmd_name} is not a command'
fi




# Set initial output path for commands.
local out_path
case $cmd_name in
  (tags|complete|makecomp)
      out_path="$completions_dir"  ;; # Completion commands.
  (*) out_path="$functions_dir"    ;; # Autoload function commands.
esac

# Set output subdirectory with: -d <dir>.
if [[ ${+opts[-d]} -eq 1 ]]; then
  out_path+="/${opts[-d]}"
fi

# Check that output directory exists.
if [[ ! -d $out_path ]]; then
  error -1 -m 'invalid function subdirectory: ${out_path}'
fi




# Set function file to the file path stored in 'functions_source'.
if [[ -z $functions_source[$function_name] ]]; then
#  autoload +X $function_name &>/dev/null
echo +X $function_name
fi
typeset function_file=${functions_source[$function_name]}

if [[ "$function_file" =~ "[.]zwc" ]]; then
  local zwc_source="$function_file"
  function_file="$( builtin zcompile -t ${zwc_source:h} |
                    /usr/bin/grep -e ${zwc_source:t}'$' )"
fi

# Set list of all files in fpath that match function name.
typeset -aU matching_files=( $function_file )
typeset -aU search_paths=( ${fpath[@]} )




# Specific settings for commands.
case $cmd_name in
  (log|cd) ;;
  
  
  # zfn make
  (make|makecomp)
    if [[ $cmd_name == 'make' ]]; then
      out_path+="/$function_name"
    elif [[ $cmd_name == 'makecomp' ]]; then
      out_path+="/_$function_name" 
    fi
    
    # Check that function file does not exist.
    if [[ -e $out_path ]]; then
      # Open file if '-o' is set.
      if [[ ${+opts[-o]} -eq 1 ]]; then
        /usr/bin/open -a Xcode -- $out_path
        return 0
      fi
      error -1 -m 'file already exists: ${out_path}'
    fi
    
    # If '-w' is set, write template to output path.
    if [[ ${+opts[-w]} -eq 1 ]]; then
      zt_options=([--out]="$out_path")
    else
      __zfn_require_write_permission
    fi
  ;;
  
  
  # Display commands allow function name to be a pattern.
  (open|where|print|show)
    # If '-d' is set, search in subdirectory instead of fpath.
    if [[ ${+opts[-d]} -eq 1 ]]; then
      search_paths=( $out_path )
    fi
    # Find all files that match 'function_name' and
    # add them to 'matching_files[]'.
    /usr/bin/find --               \
        ${search_paths[@]}         \
        -name "${~function_name}"  \
        -type f                    \
        -mindepth 1 -maxdepth 1    \
        2>/dev/null |
    pipeset -aU matching_files
    # Check that there is at least one matching source file.
    if [[ ${#matching_files} -eq 0 ]]; then
      error -1 -m 'function not found: ${function_name}'
    fi
  ;;
  
  
  # Other commands require function name must refer to an existing function.
  (*)
    # Check function name.
    if [[ -z "$function_name" ]]; then
      error -1 -m 'function name is not specified'
    fi
    # Check that 'function_name' is a function.
    if [[ ${+functions[$function_name]} -eq 0 ]]; then
      error -1 -m '${function_name} is not a function'
    fi
  ;;
esac




# Invoke ZFN command with arguments.
$CMD "$@"
return $?

}
