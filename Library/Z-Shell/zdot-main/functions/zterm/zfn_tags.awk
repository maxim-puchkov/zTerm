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

# printfg
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









#MARK: - Begin
# Begin AWK program.
BEGIN {
  # ZFN-TAG output delimiter.
  OFS = get_env("ZFN_DELIMITER", OFS);
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
  # Declarative tag labels.
  define_tag = tag_word("define");
  annotation_tag = tag_word("annotation");
  # Defined tag label.
  option_tag = tag_word("option");
}

BEGIN {
  # Misc. variables: shell function declaration.
  function_decl = "^[[:blank:]]*(function|[[:alnum:]_\-]+[[:blank:]]*[(][)][[:blank:]]*[{])[[:blank:]]*";
}









# Remove comment and tag prefix from every line.
{
  sub("^[[:print:]]*[[:blank:]]*[#]+[[:blank:]]*", "", $0);
}

# Skip lines that do not begin with a metacharacter.
($0 !~ metachar) {
  next;
}









# Parse '@define <tag-name> <completion>' tags.
(tolower($1) ~ define_tag) {
  # Name of a new tag.
  tagname = $2;
  tag = tag_word(tagname);
  if ($3 != "") {
    # Completion action (format: "[num]: :->[state]").
    tagaction = substr($0, match($0, "[" $3 "]"));
  } else {
    tagaction = "";
  }
  
  # Add defined tag.
  DEFINED_TAGS[tag] = tagaction;
  DEFINITIONS[d++] = tagchar "define" OFS tagname OFS tagaction;
#  print(tagchar "define", tagname, tagaction);
  
  next;
}




# Parse '@annotation <tag-name> <annotation-text>' tags.
(tolower($1) ~ annotation_tag) {
  # Name of an annotated tag.
  tag = tag_word($2);
  # Annotation text.
  text = $3;
  # If tag is defined, add annotation.
  if (tag in DEFINED_TAGS) {
    ANNOTATIONS[text] = tag;
  }
  
  next;
}









# format_description
# Format '+description' value.
function format_description(text) {
  first = substr(text, 1, 1);
  sub("^"first, tolower(first), text);
  sub("[.,;]+$", "", text);
  return text;
}

# reset_tag
# Reset all tags words.
function reset_tag() {
  for (w = 1; w <= words_count; w++) {
    TAG[TAGWORDS[w]] = "";
  }
}

# print_tag
# Print all tags and clear TAG array.
function print_tag() {
  # Always print @taglabel tags first.
  output = TAG["taglabel"];
  delete TAG["taglabel"];
  
  # Print other tags separated with delimiter.
  for (w = 1; w <= words_count; w++) {
    word = TAGWORDS[w];
    value = TAG[word];
    if (word ~ "description") {
      value = format_description(value);
    }
    output = output OFS value;
  }
  
  # Add tag output line to print at the END.
  TAGS[t++] = output;
  reset_tag();
}




# Parse an annotation of a defined tag.
($1 in ANNOTATIONS) &&
(ANNOTATIONS[$1] in DEFINED_TAGS) {
  # End previous tag.
  if (length(TAG) > 0) {
    print_tag();
  }
  
  # Annotated tag.
  tag = ANNOTATIONS[$1];
  # Description text.
  desc = $0;
  # Tag argument name.
  name = "";
  
  if (matches(tag, option_tag)) {
    # Annotation format for the '@option' tag.
      # @define           option
      # @annotation       option <annotation-text>
      # ...
      #
      # <annotation-text> -o,--option Description for option '-o'.
      # ...
    name = $2;
    sub("[[:punct:]]*$", "", name);
    sub("^.*" name "[[:punct:]]*[[:blank:]]+", "", desc);
  } else {
    # Annotation format for command 'bar' of function 'foo':
      # @define       <tag> [[<arg-number>]<action>]
      # @annotation   <tag> <annotation-text>
      # ...
      #
      #[annotation-text] Description for 'foo bar'.
      # function foo_bar() {
      #   ...
      # }
    getline name;
    if (name !~ function_decl) {
      next;
    }
    sub("^[[:blank:]]*" $1 "[[:blank:]]*", "", desc);
    sub(".*[:]", "", desc);
    sub("^[[:blank:]]*function[[:blank:]]*", "", name);
    sub("[[:blank:]]*\\(.+$", "", name);
    sub(v_prefix, "", name);
  }
  
  # Set tag properties.
  TAG["taglabel"] = tag;
  TAG["name"] = name;
  TAG["description"] = desc;
}


# Parse a defined tag (e.g., @option <name>).
($1 in DEFINED_TAGS) {
  # End previous tag.
  if (length(TAG) > 0) {
    print_tag();
  }
  
  # Tag @label.
  tag = $1;
  # Tag argument name.
  name = $2;
  
  TAG["taglabel"] = tag;
  TAG["name"] = name;
}


# Parse tag descriptors
# (e.g., [@+]description <value>, [@+]completion <value>).
($1 ~ metachar) {
  # Skip tags that do not describe a defined tag.
  if (length(TAG) == 0) {
    next;
  }
  
  # Descriptor word.
  word = $1;
  sub(metachar, "", word);
  # Descriptor value.
  value = $0;
  sub(metachar "[[:blank:]]*" word "[[:blank:]]*", "", value);
  
  if (word ~ "description") {
    value = format_description(value);
  }
  TAG[word] = value;
}









# End AWK program.
END {
  if (NR == 0) {
    exit(1);
  }
}

END {
  if (TAG["taglabel"] in DEFINED_TAGS) {
    print_tag();
  }
}

END {
  def_count = length(DEFINITIONS);
  for (d = 0; d < def_count; d++) {
    print DEFINITIONS[d];
  }

  tags_count = length(TAGS);
  for (t = 0; t < tags_count; t++) {
    print TAGS[t];
  }
  
  exit(0);
}
