# zTerm 2
zTerm is a framework for managing zsh configuration. It includes zsh functions, completions, as well as AppleScript script libraries and zsh interface functions.  


# Functions
Below is a brief description of some functions included in zTerm 2.    
[View all functions](zsh/functions)  


## Extended Commands
Functions which extend shell builtins. 
* `cd` - modified `cd` zsh builtin that prints new working directory and lists its contents.
* `pwd` - modified `pwd` zsh builtin that automatically prints logical and physical working directories if they are not the same. 
* `pipeset` - modified `typeset` zsh builtin that can be used to set parameters from standard or piped input.
```sh
  echo "A\nZ" | pipeset -a array  # array=(A Z)  
```
* `error` - print error message and `return` from the calling function.


## Display
Functions for formatting and displaying text.
* `spectrum` - set FG, BG, FX and fg, bg, fx arrays.
```sh
  spectrum -p  # set arrays FG,BG,FX
  spectrum -e  # set arrays fg,bg,fx
  spectrum -u -cdnz -FBX  # (re)set arrays FG,BG,FX,fg,bg,fx, style functions, and style aliases
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


### zterm Functions (old)
Functions which manage other functions.
* `zfd` - list functions in autoload functions' directory.
* `zfn` - create, edit, and autocomplete for zsh functions.
```sh
  # Add zfn-tags to function source.
  function foo {
    # @define option
    # @option -x
    # @option -y
    # 
    # @define command
    # @command bar
    function foo_bar() { ... }
    ...
  }
```
```sh
  # Create completion function for foo's options '-x', '-y' and command 'foo bar'.
  zfn -w makecomp foo 
```
