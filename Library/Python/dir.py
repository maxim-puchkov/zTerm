#!/usr/bin/env python3.7

import sys
import iterm2

if len(sys.argv) < 2:
  print("Specify an object to show")
  exit(1)





def red(text):
  return '\033[31m' + text + '\033[39m'

def grey(text):
  return '\033[37m' + text + '\033[39m'


def print_section(title, body):
  print('>', red(str(title)) + "\t" + grey(str(body)))
  return


object_name = sys.argv[1]
object = eval(object_name)


print_section(object_name, str(dir(object)))

