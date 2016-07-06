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

if !exists("g:auto_save")
  let g:auto_save = 0
endif

if !exists("g:auto_save_no_updatetime")
  let g:auto_save_no_updatetime = 0
endif

if !exists("g:auto_save_in_insert_mode")
  let g:auto_save_in_insert_mode = 1
endif

if g:auto_save_no_updatetime == 0
  set updatetime=1000
endif

if !exists("g:auto_save_silent")
  let g:auto_save_silent = 0
endif

if !exists("g:auto_save_events")
  let g:auto_save_events = [ "CursorHold", "InsertLeave" ]
endif

if !exists("g:auto_save_keep_marks")
  let g:auto_save_keep_marks = 1
endif

if !exists("g:auto_save_write_all_buffers")
  let g:auto_save_write_all_buffers = 0
endif

augroup auto_save
  autocmd!
  if g:auto_save_in_insert_mode == 1
    let g:auto_save_events = g:auto_save_events + [ "CursorHoldI", "CompleteDone" ]
  endif

  for event in g:auto_save_events
    execute "au " . event . " * nested call AutoSave()"
  endfor
augroup END

command! AutoSaveToggle :call AutoSaveToggle()

function! AutoSave()
  if g:auto_save >= 1
    let was_modified = &modified
    if g:auto_save_keep_marks >= 1
      let first_char_pos = getpos("'[")
      let last_char_pos = getpos("']")
      call DoSave()
      call setpos("'[", first_char_pos)
      call setpos("']", last_char_pos)
    else
      call DoSave()
    endif
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
  if g:auto_save >= 1
    let g:auto_save = 0
    echo "AutoSave is OFF"
  else
    let g:auto_save = 1
    echo "AutoSave is ON"
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
