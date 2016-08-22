"======================================
"    Script Name:  vim-auto-save (http://www.vim.org/scripts/script.php?script_id=4521)
"    Plugin Name:  AutoSave
"        Version:  0.1.7
"======================================

if exists("g:auto_save_loaded")
  finish
else
  let g:auto_save_loaded = 1
endif

let s:save_cpo = &cpo
set cpo&vim


if !exists("g:auto_save_silent")
  let g:auto_save_silent = 0
endif

if !exists("g:auto_save_events")
  let g:auto_save_events = [ "InsertLeave", "TextChanged" ]
endif

if !exists("g:auto_save_write_all_buffers")
  let g:auto_save_write_all_buffers = 0
endif

"Check if user added the CompleteDone event which is known to
"cause problems for certain vim versions.
if !(v:version > 703 || v:version == 703 && has('patch598'))
  let completeDoneIndex = index(g:auto_save_events,"CompleteDone")
  if (completeDoneIndex >= 0)
    call remove(g:auto_save_events,completeDoneIndex)
    echo "(AutoSave) Save on CompleteDone is not supported for your vim version."
    echo "(AutoSave) CompleteDone was removed from g:auto_save_events variable."
  endif
endif

augroup auto_save
  autocmd!
  for event in g:auto_save_events
	  " TODO see http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers
	  " bufdo
    execute "au " . event . " * nested  call AutoSave()"
  endfor
augroup END

command! AutoSaveToggle :call AutoSaveToggle()

function! AutoSave()
  if !exists("b:auto_save")
	let b:auto_save = 0
  endif
  if b:auto_save >= 1
    let was_modified = &modified

    " preserve marks that are used to remember start and 
    " end position of the last changed or yanked text (`:h '[`).
    let first_char_pos = getpos("'[")
    let last_char_pos = getpos("']")
    call DoSave()
    call setpos("'[", first_char_pos)
    call setpos("']", last_char_pos)

    if was_modified && !&modified
      if exists("g:auto_save_postsave_hook")
        execute "" . g:auto_save_postsave_hook
      endif
      if g:auto_save_silent == 0
        echo "(AutoSaved at " . strftime("%H:%M:%S") . ")"
      endif
    endif
  endif
endfunction

function! DoSave()
  if g:auto_save_write_all_buffers >= 1
    silent! wa
  else
    silent! w
  endif
endfunction

function! AutoSaveToggle()
  if !exists("b:auto_save")
	let b:auto_save = 0
  endif
  if b:auto_save >= 1
    let b:auto_save = 0
    echo "AutoSave is OFF"
  else
    let b:auto_save = 1
    echo "AutoSave is ON"
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
