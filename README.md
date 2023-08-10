# What is zTerm?
zTerm is my personal zsh configuration which I use on daily basis. Whenever I need a new command in my terminal, I add it here. This repository contains many useful commands and aliases which help me improve my productivity when using command-line. I continuously imrpove it and add new code to it. 


# zTerm 2
zTerm is a framework for managing zsh configuration. It includes zsh functions, completions, as well as AppleScript script libraries and zsh interface functions.  


# Functions
Below is a brief description of some functions included in zTerm 2.    
[View all functions](zsh/functions)  


## Examples
### Extended Commands
Functions which extend shell builtins. 
* `cd` - modified `cd` zsh builtin that prints new working directory and lists its contents.
* `pwd` - modified `pwd` zsh builtin that automatically prints logical and physical working directories if they are not the same. 
* `pipeset` - modified `typeset` zsh builtin that can be used to set parameters from standard or piped input.
```sh
  echo "A\nZ" | pipeset -a array  # array=(A Z)  
```
* `error` - print error message and `return` from the calling function.


### Display
Functions for formatting and displaying text.
* `styles` - set FG, BG, FX and fg, bg, fx arrays which can be used for styling text
```sh
  styles -UA # set all styles
  echo "$bg[red]Hello, world$bg[default]" # use parameters directly, or use functions:
  red "Hello"      # red color (fg)
  Green-bg "World" # bright green background color (bg)
  blink "..."      # blinking text (fx)
```
* `2hex` - print ASCII input as hex.
* `order` - print characters or words in alphabetical order.
* `print-var` - print parameter's type and value.
* `show` - show information about an object (command, function, alias, parameter, etc.). 
```sh
$ show PATH
> parameters : scalar-tied-export-special PATH[29] = "/usr/bin:/bin:/usr/sbin:/sbin"
$ show ls
> aliases ls: /bin/ls -BFGHhk
> commands ls: /bin/ls
     1       ls [-ABCFGHLOPRSTUW@abcdefghiklmnopqrstuwx1%] [file ...]
```
* `synopsis` - print synopsis for a command (used by `show`). 
* `syntaxf` - underline `${variables}` or substitute red "null" string if varialble is not set (used by `error`).
* `typeof` - print type of a command or parameter.





## Util
* `mvtr` - move files to trash.
* `youtube-hd` - download HD youtube videos and audio and merge it into `.mkv` format. 
