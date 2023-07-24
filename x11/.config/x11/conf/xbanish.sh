#!/usr/bin/env bash
[[ -x /usr/bin/xbanish ]] && (pidof -s xbanish || xbanish &)
