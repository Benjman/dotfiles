#!/usr/bin/env zsh
LLVM_PATH="$HOME/.local/src/llvm-project"
if [ -d "$LLVM_PATH" ]
then
  export PATH="$LLVM_PATH/build/bin:$PATH"
  export LD_LIBRARY_PATH="$LLVM_PATH/build/lib"
fi
