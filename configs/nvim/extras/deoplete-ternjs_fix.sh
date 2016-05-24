#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# change directory to ternjs.py
cd ../bundle/deoplete-ternjs/rplugin/python3/deoplete/sources/

# add option to start server persistently
sed -i "s/self\._tern_arguments = ''/self\._tern_arguments = '--persistent'/g" ternjs.py
