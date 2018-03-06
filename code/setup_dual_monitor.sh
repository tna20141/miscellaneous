#!/bin/bash

# sets up a second monitor relative to the main one and move workspaces there

output="HDMI1"
main_output="eDP1"
# left or right
position="right"
move_workspaces="1 2 3 4 5"

if [ "$1" == "--off" ]; then
	xrandr --output $output --off
	exit
fi

xrandr --output $output --auto
xrandr --output $output --${position}-of "$main_output"

workspaces="$(i3-msg -t get_workspaces)"

for i in $move_workspaces; do
	workspace_name=$(echo $workspaces | bash -c "sed 's/.*\"name\":\"\\($i[^\"0-9]*\\).*/\\1/'")
	i3-msg "workspace $workspace_name, move workspace to output $output"
done
