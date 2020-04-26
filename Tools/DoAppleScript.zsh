#!/bin/zsh

#  DoAppleScript.zsh
#  Terminal
#
#  Created by Maxim Puchkov on 2020-04-10.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


function DoAppleScript() {
    # Primary script properties: function base,
    # sub-command, and options.
    local src                # ___FILENAME___
    typeset -A opts          # -flag, --option [option_value]
    local cmd                # Command of ___FILEMNAME___ to invoke
    local ecode=0
    
    local PREFIX="${0}_"
    local SRC_DIR="/usr/local/Terminal/AppleScript/scripts"
    local EXT='scpt'
    
    function DoAppleScript_CloseAllWindows() {
        local script="${SRC_DIR}/${0#${PREFIX}}.${EXT}"
        result=$( osascript $script )
        return $result
    }
    function DoAppleScript_CloseBackWindows() {
        local script="${SRC_DIR}/${0#${PREFIX}}.${EXT}"
        result=$( osascript $script )
        return $result
    }
    function DoAppleScript_Notify() {
        local script="${SRC_DIR}/${0#${PREFIX}}.${EXT}"
        local message="${1:-No message}"
        local title="${2:-Notification}"
        local subtitle="${3-Script executed}"
        result=$( osascript $script "$message" "$title" "$subtitle" )
        return $result
    }
    
    
    src=$( basename $0 )
    cmd=$1
    
    case $cmd in
        '')
            echo 'error'
            ;;
        *)
            shift
            ${src}_${cmd} "$@"
            ecode=$?
            if [[ $ecode = 127 ]]; then
                printf 'Unknown command: %s (Exit code: %u).\n' "$cmd" "$ecode" >&2
            fi
            ;;
    esac
    
    return $ecode
}


if [[ $# -gt 0 ]]; then
    DoAppleScript "$@"
fi
