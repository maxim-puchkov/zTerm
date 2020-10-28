#!/usr/bin/awk -f

#  zfn
#  zfn_complete.awk
#
#  Created on October 22, 2020.


# Begin AWK program.
BEGIN {
  delimiter = get_env("ZFN_DELIMITER", FS);
  #tagchars = get_env("ZFN_TAGCHARS", "@");
  tagchars = "@";
  
  define_tag = "[" tagchars "]define";
  option_tag = "[" tagchars "]option";
  command_tag = "[" tagchars "]";
  
  FS = delimiter;
  
  # Index for option, command, and tag.
  o = 0;
  c = 0;
  t = 0;
}




# get_env
# Get value of an environment variable 'var' or return default value.
function get_env(var, default_value) {
  return ENVIRON[var] != "" ? ENVIRON[var] : default_value;
}







# Ignore lines that do not match the 'v_only' pattern (set with -v).
$0 !~ v_only {
  next;
}



# Parse '@define' tag.
$1 ~ define_tag {
  tag = $2;
  action = $3;
  if (action != "") {
    TAGS[t] = tag;
    TAG_ACTIONS[t] = "'" action "'";
    DEFINED_TAGS[tag] = t;
    t++;
  }
  next;
}



# unset_option
# Set all option properties to empty string.
function unset_option() {
  opt_names = "";
  opt_exclude = "";
  opt_desc = "";
  opt_action = "";
}

# Parse '@option' tag.
$1 ~ option_tag {
  unset_option();
  
  # Option names:  -o or {-o,--option}
  opt_names = $2;
  if (opt_names ~ ",") {
    opt_names = "{" $2 "}";
  }
  # Excluded options:  (-o) or (-o --option)
  opt_exclude = "'(" $2 ")'";
  if (opt_exclude ~ ",") {
    sub(",", " ", opt_exclude);
  }
  # Description:  [description text for -o]
  opt_desc = "[" $3 "]";
  # Action:  n: :->state
  opt_action = $4;
  
  # Add option
  OPTIONS[o++] = opt_exclude opt_names "'" opt_desc opt_action "'";
}





# unset_command
# Set all command properties to empty string.
function unset_command() {
  cmd_name = "";
  cmd_desc = "";
}

# Parse command tag.
($1 in DEFINED_TAGS) {
  # Unset 'cmd_*' variables.
  unset_command();
  
  # Command name: cmd
  cmd_name = $2;
  # Description:  description text for cmd
  cmd_desc = $3;
  
  # Add command
  cmd = cmd_name ":'" cmd_desc "'"
  if ($1 in COMMANDS) {
    COMMANDS[$1] = COMMANDS[$1] " " cmd;
  } else {
    COMMANDS[$1] = cmd;
  }
}




# End AWK program.
END {
  if (NR == 0) {
    exit(1);
  }

  # Variables.
  if (v_arguments_options != "") {
    v_arguments_options = v_arguments_options " ";
  }
}

END {
  # Counts.
  tag_count = length(TAGS);
  opt_count = length(OPTIONS);
  cmd_count = length(COMMANDS);
  
  
  if (opt_count + tag_count > 0) {
    #: _arguments
    printf("_arguments -C %s", v_arguments_options);
    
    ##: '(-o --option)'{-o,--option}'[description]action'
    for (o = 0; o < opt_count; o++) {
      printf("%s ", OPTIONS[o]);
    }
    ##: '1: :->state1' '2: :->state2' ...
    for (t = 0; t < tag_count; t++) {
      printf("%s ", TAG_ACTIONS[t]);
    }
    printf("; ");
    
    
    #:  case $state in
    printf("case $state in ");
    for (t = 0; t < tag_count; t++) {
      # Set tag name, commands, and commands array name
      tag = substr(TAGS[t], 2);
      tag_cmds = COMMANDS["@" tag];
      tag_cmds_arr = v_prefix "" tag "s";
      
      # Skip tags without commands.
      if (tag_cmds == "") {
        continue;
      }
      
      ##:   (<tag>) ...
      printf("(%s) ", tag);
      ###:    typeset -a <tag>s=( cmd1:'description for cmd1' cmd2:'description for cmd2' ... )
      printf("typeset -a %s=( %s ) ; ", tag_cmds_arr, tag_cmds);
      ###:    _describe <tag>s '<tag>' <tag>s
      printf("_describe -t %s '%s' %s ; ", tag_cmds_arr, tag, tag_cmds_arr);
      ##:   ;;
      printf(";; ");
    }
    #:  esac
    printf("esac ; ");
  }
  
  
  #: return 0
  printf("return 0 ; ");
  printf("\n");
}
