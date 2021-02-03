#!/bin/bash

listfile="exclude-dir/exclude-list.txt"
if [ -f "exclude-list.txt" ] ; then
	listfile="exclude-list.txt"
fi

workdir=".."
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"
fi

rsync -vr --exclude-from $listfile . $workdir
