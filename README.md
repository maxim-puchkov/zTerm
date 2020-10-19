# zTerm 2
Useful command line automation scripts.    

zTerm is a collection of various scripts (mostly `zsh`; also `applescript`, `python`, `awk`, `sed`, `perl`) for (primarily) interactive `zsh` shells.  

zTerm includes `zsh` startup files ([zshenv](Library/Z-Shell/zshenv), [.zshrc](Library/Z-Shell/zdot-main/.zshrc), [.zprofile](Library/Z-Shell/zdot-main/.zprofile), etc.) and `zsh` [autoload functions](Library/Z-Shell/zdot-main/functions) and function completions.  


# Functions
Below is a brief description of some functions included in zTerm 2.    
[View all functions](Library/Z-Shell/zdot-main/functions)  

## Templates
* `mkfn` - make a new autoload function.
* `takef` - make a file and open it in Xcode for editing.
* `ztemplate` - make a template file (used by `mkfn`).



## Extended Commands
* `cd` - modified `cd` `zsh` builtin that prints new working directory and lists its contents.
* `pwd` - modified `pwd` `zsh` builtin that automatically prints logical and physical working directories if they are not the same. 
* `pipeset` - modified `typeset` `zsh` builtin that can be used to set parameters from standard or piped input.
```sh
  echo "A\nZ" | pipeset -a array  # array=(A Z)  
```


## Display
Functions for formatting and displaying text.
* `2hex` - print ASCII input as hex.
* `error` - print error message and return from the calling function.
* `highlight` - highlight syntax (with `pygmentize`).
* `highlight-column` - highlight a column in text.
* `order` - print characters or lines in alphabetical order.
* `print-var` - print variable (used by `show`).
* `println` - modified `print` `zsh` builtin that uses options and flags (instead of prompt expansion with `-P`) to set text style. 
* `show` - show an object (command, function, alias, parameter, etc.). 
* `synopsis` - print synopsis for a command (used by `show`). 
* `syntaxf` - highlight variables in text (used by `error`).
* `typeof` - print type of object.


## Plist
* `mkpl` - make an empty property list file. 


## Util
* `sound` - play a system sound.
* `watchfile` - create a `zsh` script and run it at some interval.
* `youtube-hd` - download HD youtube videos and audio and merge it into `.mkv` format. 


### Other
* `fn` - legacy function for finding, editing, displaying, and generating completion for `zsh` functions.
* `cpl` - automatically parse and generate `zsh` function completion.

