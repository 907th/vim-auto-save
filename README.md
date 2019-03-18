# Description

AutoSave - automatically saves changes to disk without having to use `:w`
(or any binding to it) every time a buffer has been modified or based on your
preferred events.

Inspired by the same feature in RubyMine text editor.

By default AutoSave will save every time something has been changed in normal
mode and when the user leaves insert mode. This configuration is a mix between
"save as often as possible" and "try to avoid breaking other plugins that depend
on filewrite-events".


# Installation

Use [vundle](https://github.com/gmarik/vundle) or
download [packaged version](http://www.vim.org/scripts/script.php?script_id=4521)
from vim.org.


# Usage

AutoSave is disabled by default, run `:AutoSaveToggle` to enable/disable it.


# Options

## Enable on Startup

If you want the plugin to be enabled on startup use the `g:auto_save` option.

```VimL
" .vimrc
let g:auto_save = 1  " enable AutoSave on Vim startup
```

It's also possible to override global `g:auto_save` value individually per buffer or window. For example, if you have auto save enabled globally, you can opt out some files. And vice versa, opt in some files, when you have auto save disabled globally.

```vim
let g:auto_save = 0
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
augroup END
```

## Silent

AutoSave will display on the status line on each auto-save by default:

```
(AutoSave) saved at 08:40:55
```

You can silence the display with the `g:auto_save_silent` option:

```VimL
" .vimrc
let g:auto_save_silent = 1  " do not display the auto-save notification
```

## Events

The events on which AutoSave will perform a save can be adjusted using the
`g:auto_save_events` option. Using `InsertLeave` and `TextChanged` only,
the default, will save on every change in normal mode and every time you leave insert mode.

```VimL
" .vimrc
let g:auto_save_events = ["InsertLeave", "TextChanged"]
```

Other events you may want to use:

- `TextChangedI` will save after a change was made to the text in the current buffer in insert mode.
- `CursorHold` will save every amount of milliseconds as defined in the `updatetime` option in normal mode.
- `CursorHoldI` will do the same thing in insert mode.
- `CompleteDone` will also trigger a save after every completion event.

Some of these commands may not be available, depending on your Vim installation.
See the autocommands overview for a complete listing (`:h autocommand-events`).

**Warning!** Be advised to be careful with the `updatetime` option since it has shown to
cause problems when set too small. 200 seems already to be too small to work
with certain other plugins. Use 1000 for a more conservative setting.

## (Pre/Post)save Hooks

If you need an autosave hook (such as generating tags post-save, or aborting the save earlier)
then use `g:auto_save_postsave_hook` or `g:auto_save_presave_hook` options:

```VimL
" .vimrc

" This will run :TagsGenerate after each save
let g:auto_save_postsave_hook = 'TagsGenerate'

" This will run AbortIfNotGitDirectory function before each save
let g:auto_save_presave_hook = 'call AbortIfNotGitDirectory()'

" Example hook from vim-auto-save-git-hook plugin
function! AbortIfNotGitDirectory()
  if ...
    let g:auto_save_abort = 0
  else
    let g:auto_save_abort = 1
  endif
endfunction
```

## Write to All Buffers

By default only the current buffer is written (like `:w`). You can choose that
all buffers are written on autosave using the `g:auto_save_write_all_buffers`
option (like `:wa`).

```VimL
" .vimrc
let g:auto_save_write_all_buffers = 1  " write all open buffers as if you would use :wa
```


# Development

The `doc/auto-save.txt` is a converted version of the `README.md`. Don't edit
it directly. Instead install the [md2vim](https://github.com/FooSoft/md2vim) and
run the `update_doc_from_readme.sh` script.


# Contribution or Bug Report

Development is made in [907th/vim-auto-save](https://github.com/907th/vim-auto-save) repo.
Please, report any bugs and/or suggestions there. Any contrubution is welcomed!


# License

Distributed under the MIT License (see LICENSE.txt).

Copyright (c) 2013-2016 Alexey Chernenkov
