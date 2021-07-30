#!/bin/sh
man $@ | vim -R -c 'set ft=man' -
