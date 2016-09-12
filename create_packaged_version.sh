#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

VERSION=`head plugin/AutoSave.vim | sed -n 's/.*Version:[ ]*\([0-9.]*\).*/\1/p'`
echo "Packaging version $VERSION"

OUTPUT="packaged/vim-auto-save-$VERSION.tar.gz"
echo "Writing to $OUTPUT"

mkdir -p packaged
tar -czf $OUTPUT --exclude='.git*' --exclude='*.sh' --exclude='packaged/*' .
echo "Done"
