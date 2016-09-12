#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

md2vim_bin=""

if hash md2vim 2> /dev/null; then
    md2vim_bin="md2vim"
elif [ -s $GOPATH/bin/md2vim ]; then
    md2vim_bin=$GOPATH/bin/md2vim
else
    echo "md2vim executable not found in \$PATH and neither in \$GOPATH."
    echo "See README.md for instructions how to install it."
    exit 1
fi

echo "Building documentation"
$md2vim_bin -desc "*AutoSave* *auto-save* *vim-auto-save*" README.md doc/auto-save.txt
echo "Done"
