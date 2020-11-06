#!/usr/bin/awk -f

#  zfn
#  zfn_help.awk
#
#  Created on October 30, 2020.

BEGIN {
  if (v_tagchar == "") {
    tagchar = "@";
  } else {
    tagchar = v_tagchar;
  }
}

($0 ~ tagchar "define") {
  next;
}


{
  print($2, $3);
}
