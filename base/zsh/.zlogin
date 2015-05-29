# startx on login on tty1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec $XDG_CONFIG_HOME/X11/session-init

[[ $XDG_VTNR -ne 1 ]] && command fortune
