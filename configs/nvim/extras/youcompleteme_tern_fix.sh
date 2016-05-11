#!/bin/bash

# change directory to YouCompleteMe
cd ../bundle/YouCompleteMe/third_party/ycmd/

# assuming only 1 file is found
file=$(find . -name "tern_completer.py")

# edit: 'stdin_windows' -> 'stdin'
sed -i 's/stdin_windows/stdin/g' "$file"
