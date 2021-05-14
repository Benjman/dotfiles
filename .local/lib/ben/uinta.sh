#!/bin/sh

# Opens the Uinta Engine in the VIM editor
currentDir=$PWD
cd ~/src/uinta
set PATH+=~/.config/ben/bin/
vim -S ~/.config/ben/uinta.vim .
cd $currentDir
