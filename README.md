# AutoSave

## Description

AutoSave - automatically save changes to disk without having to use `:w` (or any binding to it) every time a buffer has been modified.

Inspired by the same feature in RubyMine text editor.

## Installation and Usage

Use [vundle](https://github.com/gmarik/vundle) to install the plugin.

Also you can download [packaged version](http://www.vim.org/scripts/script.php?script_id=4521) from vim.org.

AutoSave is disabled by default, run `:AutoSaveToggle` to enable/disable it.  
If you want plugin to be always enabled it can be done with`g:auto_save` option:

```VimL
" .vimrc
let g:auto_save = 1

```

## License

Distributed under the MIT License (see LICENSE.txt).

Copyright (c) 2013 Alexey Chernenkov
