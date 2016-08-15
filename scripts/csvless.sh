#!/bin/bash
## I often use csvlook | less -S 
## make it a function so that I only need to use csvless
## check csvkit https://csvkit.readthedocs.io/en/0.9.1/
## Here $@ is a “magic” variable that points to all of the arguments passed to the command.

set -e
set -u
set -o pipefail

## in strick mode, if vawk is not installed, the whole program will exit instantly, add || true
## to make the exit code to 0.
CSVLOOK=$(which csvlook || true)

if [[ ! -f "$CSVLOOK" ]]
then
	echo -e "Error: csvkit is not installed, please install it from https://csvkit.readthedocs.io/en/0.9.1/"
	exit 1
fi

csvlook $@ | less -S
