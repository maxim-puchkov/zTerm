#!/usr/bin/awk -f

#  zfn
#  zfn_tags.awk
#
#  Created on October 22, 2020. 


# get_env
# Get value of an environment variable 'var' or return default value.
function get_env(var, default_value) {
  return ENVIRON[var] != "" ? ENVIRON[var] : default_value;
}


function printfg(color, text) {
  fg_color = "[" color "m";
  fg_default = "[39m";
  printf("%s%s%s\n", fg_color, text, fg_default);
}
function red(text) {
  printfg(31, text);
}
function green(text) {
  printfg(32, text);
}
function yellow(text) {
  printfg(33, text);
}
function blue(text) {
  printfg(34, text);
}
function magenta(text) {
  printfg(35, text);
}
function cyan(text) {
  printfg(36, text);
}
function grey(text) {
  printfg(37, text);
}



function tag_word(tagname) {
  
  return tagchar tagname
}



# Begin AWK program.
BEGIN {
  delimiter = get_env("ZFN_DELIMITER", "::");
  tagchar = "@";
  
  words = get_env("ZFN_TAGWORDS", "name::description::completion");
  words_count = split(words, TAGWORDS, delimiter);
  
  value_prefix = "[" tagchar "][[:alnum:]_\-]+[[:blank:]]*";
  function_decl = "^[[:blank:]]*(function|[[:alnum:]_\-]+[[:blank:]]*[(][)][[:blank:]]*[{])[[:blank:]]*";
  
  define_tag = tag_word("define");
  annotation_tag = tag_word("annotation");
  option_tag = tag_word("option");
  
  
  if (tolower("@annotation") ~ annotation_tag) { red("YES"); }
}




# Skip lines that are not comments.
$0 !~ "^[[:blank:]]*[#]" {
  next;
}

# Remove comment prefix from every line.
$0 ~ "^[[:blank:]]*[#]" {
  sub("^[[:blank:]]*[#]+[[:blank:]]*", "", $0);
}


# Parse '@define <tag_name> <completion>' tags.
tolower($1) ~ define_tag {
  tagname = tag_word($2);
  
  if ($3 != "") {
    action = $0;
    sub("^.+" $2 "[[:blank:]]*", "", action);
  } else {
    action = "";
  }
  DEFINED_TAGS[tagname] = action;
  printf("@define%s%s%s%s\n", delimiter, tagname, delimiter, action);
  
  next;
}


# Parse '@annotation <tag> <text>'
tolower($1) ~ annotation_tag {
  tagname = tag_word($2);
  text = $3;
  if (tagname in DEFINED_TAGS) {
    ANNOTATIONS[text] = tagname;
  }
  
  next;
}










# reset_tags
# Reset all tags words.
function reset_tags() {
  for (w = 1; w <= words_count; w++) {
    TAGS[TAGWORDS[w]] = "";
  }
}

# print_tags
# Print all tags and clear TAGS array.
function print_tags() {
  # Always print '@groupname' tag first.
  groupname = TAGS["groupname"];
  printf("%s", groupname);
  delete TAGS["groupname"];
  # Print other tags separated with delimiter.
  for (w = 1; w <= words_count; w++) {
    word = TAGWORDS[w];
    printf("%s%s", delimiter, TAGS[word]);
  }
  printf("\n");
  reset_tags();
}

# format_description
# Format '@description' value.
function format_description(text) {
  first = substr(text, 1, 1);
  sub("^"first, tolower(first), text);
  sub("[.,;]+$", "", text);
  return text;
}

function is_option_annotation(annotation) {
  return match(annotation, option_tag) != 0;
}


#($1 in ANNOTATIONS) {
#  for (t in DEFINED_TAGS) { cyan(t); }

#}

# Parse an annotated defined tag.
($1 in ANNOTATIONS) &&
(ANNOTATIONS[$1] in DEFINED_TAGS) {

  if (length(TAGS) > 0) {
    print_tags();
  }
  
  anno = ANNOTATIONS[$1];
  
  
#  is_option_anno = (match(anno, option_tag) != 0);
  
  desc = $0;
  if (is_option_annotation(anno)) {
    name = $2;
    
    sub("[[:punct:]]*$", "", name)
    sub("^.*" $2 "[[:blank:]]*", "", desc);
    
    
    TAGS["groupname"] = anno;
    TAGS["name"] = name;
    TAGS["description"] = desc;
    
    
    red("Args: " name " + "desc )
    
    
    
    
    
  } else {
    # Annotation format for command 'bar' of function 'foo':
      # @define       command [action]
      # @annotation   command [annotation-text]
      # ...
      #
      #[annotation-text] Description for foo's bar command.
      # function foo_bar() {
      #   ...
      # }
    getline name;
    if (name ~ function_decl) {
      blue(desc);
      sub("^[[:blank:]]*" $1 "[[:blank:]]*", "", desc);
      sub("^[[:blank:]]*function[[:blank:]]*", "", name);
      sub("[[:blank:]]*\\(.+$", "", name);
      sub(v_prefix, "", name);
      
      TAGS["groupname"] = anno;
      TAGS["name"] = name;
      TAGS["description"] = desc;
    }
  }
}




# Parse a defined tag.
($1 in DEFINED_TAGS) {
  if (length(TAGS) > 0) {
    print_tags();
  }
  TAGS["groupname"] = $1;
  TAGS["name"] = $2;
}


# Parse other tags.
!($1 in ANNOTATIONS)  &&
!($1 in DEFINED_TAGS) {
for (a in ANNOTATIONS) { print a; }
  if (length(TAGS) == 0) {
    next;
  }
  
  name = $1;
  sub("^[" tagchar "]", "", name);
  value = $0;
  sub(value_prefix, "", value);
  
  if (name ~ "description") {
    value = format_description(value);
  }
  TAGS[name] = value;
}




# End AWK program.
END {
  if (TAGS["groupname"] in DEFINED_TAGS) {
    print_tags();
  }
}
