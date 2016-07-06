# AutoSave

## Description

AutoSave - automatically save changes to disk without having to use `:w` (or any binding to it) every time a buffer has been modified or based on your preferred events.

Inspired by the same feature in RubyMine text editor.

By default AutoSave will save every time something has been changed in normal mode and when the user leaves insert mode. This configuration is a mix between "save as often as possible" and "try to avoid breaking other plugins that depend on filewrite-events". 

## Installation and Usage

Use [vundle](https://github.com/gmarik/vundle) or
download [packaged version](http://www.vim.org/scripts/script.php?script_id=4521) from vim.org.

AutoSave is disabled by default, run `:AutoSaveToggle` to enable/disable it.  
If you want plugin to be always enabled it can be done with `g:auto_save` option:

```VimL
" .vimrc
let g:auto_save = 1  " enable AutoSave on Vim startup

```


AutoSave will display on the status line on each auto-save by default.

```
(AutoSaved at 08:40:55)
```

You can silence the display with the `g:auto_save_silent` option:

```VimL
" .vimrc
let g:auto_save_silent = 1  " do not display the auto-save notification

```

If you need an autosave hook (such as generating tags post-save) then use `g:auto_save_postsave_hook` option:

```VimL
" .vimrc
let g:auto_save_postsave_hook = 'TagsGenerate'  " this will run :TagsGenerate after each save
```

The events on which AutoSave will perform a save can be adjusted using the `g:auto_save_events` option.
Using `InsertLeave` and `TextChanged` only, the default, will save on every change in normal mode and every time you leave insert mode.

```.VimL
let g:auto_save_events = ["InsertLeave", "TextChanged"]
```

Using `CursorHold` will additionally save every amount of milliseconds as defined in the `updatetime` option in normal mode.
`CursorHoldI` will do the same thing in insert mode. `CompleteDone` will also trigger a save after every completion event. See the autocommands overview for a complete listing (`:h autocommand-events`).

Be advised to be careful with the `updatetime` option since it has shown to cause problems when set too small. 200 seems already to be too small to work with certain other plugins. Use 1000 for a more conservative setting.

```.VimL
".vimrc
let updatetime=200
let g:auto_save_events = [ "CursorHold", "CursorHoldI", "CompleteDone", "InsertLeave" ]
```

The `g:auto_save_keep_marks` option fixes the [selecting your pasted
text](http://vim.wikia.com/wiki/Selecting_your_pasted_text) mapping.
This options default value is `1`.
Without it, the mapping will select the whole buffer, because a write operation sets
the `'[` and `']` marks respectively to the start and end of the buffer. If you
want vims default behavior, set the options value to 0:

```VimL
let g:auto_save_keep_marks = 0 " Don't keep the '[ and '] marks. It will break
                               " the selecting your pasted text mapping:
                               " http://vim.wikia.com/wiki/Selecting_your_pasted_text
```
By default only the current buffer is written (like `:w`). You can choose that all buffers are written on autosave using the `g:auto_save_write_all_buffers` option (like `:wa`).

```VimL
let g:auto_save_write_all_buffers = 1 " Setting this option to 1 will write all
                                      " open buffers as if you would use
                                      " :wa on the vim command line.
```

## Contribution

Development is made in [907th/vim-auto-save](https://github.com/907th/vim-auto-save) repo.  
Feel free to contribute!

## License

Distributed under the MIT License (see LICENSE.txt).

Copyright (c) 2013-2015 Alexey Chernenkov
