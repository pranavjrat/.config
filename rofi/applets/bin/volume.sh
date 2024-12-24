#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Volume

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Volume Info
mixer="`amixer info Master | grep 'Mixer name' | cut -d':' -f2 | tr -d \',' '`"
speaker="`amixer get Master | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]'`"
mic="`amixer get Capture | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]'`"

active=""
urgent=""

# Speaker Info
amixer get Master | grep '\[on\]' &>/dev/null
if [[ "$?" == 0 ]]; then
	active="-a 1"
	stext='Mute' # You can change this to something like 'Active'
	sicon=''
else
	urgent="-u 1"
	stext='Unmute'
	sicon=''
fi

# Microphone Info
amixer get Capture | grep '\[on\]' &>/dev/null
if [[ "$?" == 0 ]]; then
    [ -n "$active" ] && active+=",3" || active="-a 3"
	mtext='Unmute' # Change to 'Active'
	micon=''
else
    [ -n "$urgent" ] && urgent+=",3" || urgent="-u 3"
	mtext='Mute'
	micon=''
fi

# Theme Elements
prompt="S:$stext, M:$mtext"
mesg="$mixer - Speaker: $speaker, Mic: $mic"

# Window size configuration based on theme
if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='5'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='5'
	win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='5'
	win_width='520px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='5'
	list_row='1'
	win_width='670px'
fi

# Options (shifted option 4 to 1st and moved others down)
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Settings"  # option 4 is now the first
	option_2=" Increase"
	option_3="$sicon $stext"
	option_4=" Decrease"  # previous option 3 becomes option 4
else
	option_1=""  # option 4 is now the first
	option_2=""
	option_3="$sicon"
	option_4=""  # previous option 3 becomes option 4
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd  # added option_4 here
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		amixer -Mq set Master,0 5%+ unmute
	elif [[ "$1" == '--opt2' ]]; then
		amixer set Master toggle
	elif [[ "$1" == '--opt3' ]]; then
		amixer -Mq set Master,0 5%- unmute
	elif [[ "$1" == '--opt4' ]]; then  # handle option 4 (Settings)
		# Open Settings
		pavucontrol
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt4  # Execute Settings
        ;;
    $option_2)
		run_cmd --opt1  # Execute Increase
        ;;
    $option_3)
		run_cmd --opt2  # Execute Mute/Unmute
        ;;
    $option_4)
		run_cmd --opt3  # Execute Decrease
        ;;
esac

