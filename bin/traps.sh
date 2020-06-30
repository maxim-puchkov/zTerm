#!/usr/bin/env zsh

#  run


trap 'echo "EXIT    status $?"'    EXIT
trap 'echo "HUP     status $?"'     HUP
trap 'echo "INT     status $?"'     INT
trap 'echo "QUIT    status $?"'    QUIT
trap 'echo "ILL     status $?"'     ILL
trap 'echo "TRAP    status $?"'    TRAP
trap 'echo "ABRT    status $?"'    ABRT
trap 'echo "EMT     status $?"'     EMT
trap 'echo "FPE     status $?"'     FPE
trap 'echo "KILL    status $?"'    KILL
trap 'echo "BUS     status $?"'     BUS
trap 'echo "SEGV    status $?"'    SEGV
trap 'echo "SYS     status $?"'     SYS
trap 'echo "PIPE    status $?"'    PIPE
trap 'echo "ALRM    status $?"'    ALRM
trap 'echo "TERM    status $?"'    TERM
trap 'echo "URG     status $?"'     URG
trap 'echo "STOP    status $?"'    STOP
trap 'echo "TSTP    status $?"'    TSTP
trap 'echo "CONT    status $?"'    CONT
trap 'echo "CHLD    status $?"'    CHLD
trap 'echo "TTIN    status $?"'    TTIN
trap 'echo "TTOU    status $?"'    TTOU
trap 'echo "IO      status $?"'      IO
trap 'echo "XCPU    status $?"'    XCPU
trap 'echo "XFSZ    status $?"'    XFSZ
trap 'echo "VTALRM  status $?"'  VTALRM
trap 'echo "PROF    status $?"'    PROF
trap 'echo "WINCH   status $?"'   WINCH
trap 'echo "INFO    status $?"'    INFO
trap 'echo "USR1    status $?"'    USR1
trap 'echo "USR2    status $?"'    USR2
trap 'echo "ZERR    status $?"'    ZERR
trap 'echo "DEBUG   status $?"'   DEBUG

return $1
