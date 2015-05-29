[1mdiff --git a/home/skeate/.config/X11/session-xinitrc b/tmp/tmpKRfWne/X11/session-xinitrc[m
[1mindex 72b8b9c..153e3fc 100755[m
[1m--- a/home/skeate/.config/X11/session-xinitrc[m
[1m+++ b/tmp/tmpKRfWne/X11/session-xinitrc[m
[36m@@ -1,6 +1,5 @@[m
 #!/bin/sh[m
 [m
[31m-xrandr --output DVI-I-1 --primary --auto --output HDMI-0 --auto --left-of DVI-I-1 --output DVI-D-0 --auto --right-of DVI-I-1 &[m
 xrdb -load ~/.config/X11/Xresources &[m
 xset +dpms &[m
 [m
[1mdiff --git a/tmp/tmpKRfWne/X11/xorg.conf.d/10-input.conf b/tmp/tmpKRfWne/X11/xorg.conf.d/10-input.conf[m
[1mnew file mode 100644[m
[1mindex 0000000..296a53a[m
[1m--- /dev/null[m
[1m+++ b/tmp/tmpKRfWne/X11/xorg.conf.d/10-input.conf[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32mSection "InputDevice"[m
[32m+[m
[32m+[m[32m    # generated from default[m
[32m+[m[32m    Identifier     "Mouse0"[m
[32m+[m[32m    Driver         "mouse"[m
[32m+[m[32m    Option         "Protocol" "auto"[m
[32m+[m[32m    Option         "Device" "/dev/psaux"[m
[32m+[m[32m    Option         "Emulate3Buttons" "no"[m
[32m+[m[32m    Option         "ZAxisMapping" "4 5"[m
[32m+[m[32mEndSection[m
[32m+[m
[32m+[m[32mSection "InputDevice"[m
[32m+[m
[32m+[m[32m    # generated from default[m
[32m+[m[32m    Identifier     "Keyboard0"[m
[32m+[m[32m    Driver         "kbd"[m
[32m+[m[32mEndSection[m
