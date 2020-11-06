#!/usr/bin/awk -f

#  zfn
#  zfn_complete.awk
#
#  Created on October 22, 2020.


# get_env
# Get value of an environment variable 'var' or return default value.
function get_env(var, default_value) {
  return ENVIRON[var] != "" ? ENVIRON[var] : default_value;
}

# matches
# Returns true if the regular expression r occurs in string s.
function matches(s, r) {
  return (match(s, r) != 0);
}


# tag_word
# Returns name of tag prefixed with the tag metacharacter.
function tag_word(tagname) {
  return tagchar tagname;
}

# tag_array
# Returns name of an array associated with tag's commands.
function tag_array(tagname) {
  return tagname "s";
}

function printfg(color, s) {
  fg_color = "[" color "m";
  fg_default = "[39m";
  printf("%s%s%s\n", fg_color, s, fg_default);
}
function red(s)      { printfg(31, s); }
function green(s)    { printfg(32, s); }
function yellow(s)   { printfg(33, s); }
function blue(s)     { printfg(34, s); }
function magenta(s)  { printfg(35, s); }
function cyan(s)     { printfg(36, s); }
function grey(s)     { printfg(37, s); }







# Begin AWK program.
BEGIN {
  # ZFN-COMPLETE input delimiter.
  FS = get_env("ZFN_DELIMITER", FS);
  # Tied array delimiter.
  afs = ":";
}

BEGIN {
  # ZFN metacharacters.
  chars = get_env("ZFN_METACHARS", "@:+");
  split(chars, METACHARS, afs);
  # Single metacharacter regex.
  metachar = "^[" chars "]";
  gsub(afs, "", metachar);
  # Tag and Tag-Descriptor characters.
  tagchar = METACHARS[1];
  descriptorchar = METACHARS[2];
}

BEGIN {
  # ZFN tag descriptor words.
  words = get_env("ZFN_TAGWORDS", "description:completion");
  words_count = split("name" afs words, TAGWORDS, afs);
}

BEGIN {
  # Tags.
  define_tag = tag_word("define");
  annotation_tag = tag_word("annotation");
  option_tag = tag_word("option");
}

BEGIN {
  # Misc. variables: index for option, command, and tag.
  o = 0; c = 0; t = 0;
}





# Ignore lines that do not match the 'v_only' pattern (set with -v).
($0 !~ v_only) {
  next;
}









# Parse '@define[ ]tag-name[ ]tag-action' tag.
(tolower($1) ~ define_tag) {
  tagname = $2
  # Label of the defined (tagchar + tag).
  tag = tag_word(tagname);
  
  # Name of commands' array (tag + "s").
  tagarray = tag_array(tagname);
  
  # Completion action (num: :->state).
  tagaction = $3;
  if (matches($3, "^[[:digit:]]+$")) {
    # If action is a number, autocomplete action for n'th argument.
    tagaction = $3 ": :->" tagname;
  } else if ($3 == "--") {
    # If action is "--", autocomplete action.
    tagaction = ": :->" tagname;
  }
  if (tagaction != "") {
    # Add.
    TAGS[t] = tag;
    TAG_ACTIONS[t] = "'" tagaction "'";
    # Add to reverse lookup array.
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
(tolower($1) ~ option_tag) {
  # Unset previous 'opt_' variables.
  unset_option();
  
  # Option names: "-o" or "{-o,--option}".
  opt_names = $2;
  if (opt_names ~ ",") {
    opt_names = "{" $2 "}";
  }
  # Excluded options: "(-o)" or "(-o --option)".
  opt_exclude = "'(" $2 ")'";
  if (opt_exclude ~ ",") {
    sub(",", " ", opt_exclude);
  }
  # Description: "[description text for -o]".
  opt_desc = "[" $3 "]";
  # Action: "n: :->state".
  opt_action = $4;
  
  # Add option.
  OPTIONS[o++] = opt_exclude opt_names "'" opt_desc opt_action "'";
  
  next;
}






# unset_command
# Set all command properties to empty string.
function unset_command() {
  cmd_name = "";
  cmd_desc = "";
}

# Parse command tag.
($1 in DEFINED_TAGS) {
  # Unset previous 'cmd_' variables.
  unset_command();
#red($1)#FIXME: ----
  # Command name: "cmd".
  cmd_name = $2;
  # Description: "description text for cmd".
  cmd_desc = $3;
  
  # Add command.
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
}

END {
  # Program variables.
  if (v_arguments_options != "") {
    v_arguments_options = v_arguments_options " ";
  }
}

END {
  # Object counts.
  tag_count = length(TAGS);
  opt_count = length(OPTIONS);
  cmd_count = length(COMMANDS);
  
  # Print completion function.
  if (opt_count + tag_count > 0) {
    #: _arguments
    printf("_arguments -C %s", v_arguments_options);
    
    ##: '(-o --option)'{-o,--option}'[description]action'
    for (o = 0; o < opt_count; o++) {
      printf("%s ", OPTIONS[o]);
    }
    ##: '1: :->state1' '2: :->state2' ...
    for (t = 0; t < tag_count; t++) {
      if (TAG_ACTIONS[t] != "") {
        printf("%s ", TAG_ACTIONS[t]);
      }
    }
    printf("; ");
    
    
    
    #:  case $state in
    printf("case $state in ");
    for (t = 0; t < tag_count; t++) {
      # Set tag name, commands, and commands array name
      tag = substr(TAGS[t], 2);
      tag_cmds = COMMANDS["@" tag];
      tag_cmds_arr = v_prefix tag "s";
      
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
  
  exit(0);
}
