#!/bin/bash -f
#


sleep 3

#disable search buttom on Dell Chromebook 11
xmodmap	-e	'remove mod4 = Super_L'

#Switch Caps and Esc for vim
xmodmap -e	'keysym Escape = Caps_Lock'
xmodmap -e	'keycode 133 = Escape'

#Switch Caps and Ctrl for emacs
#xmodmap	-e	'remove control = Control_L'
#xmodmap	-e	'keycode 133 = Control_L'
#xmodmap	-e	'add control = Control_L'
