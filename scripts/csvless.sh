#!/bin/bash
## I often use csvlook | less -S 
## make it a function so that I only need to use csvless
## check csvkit https://csvkit.readthedocs.io/en/0.9.1/
## Here $@ is a “magic” variable that points to all of the arguments passed to the command.
csvlook $@ | less -S
