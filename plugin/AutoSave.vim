"======================================
"    Script Name:  vim-auto-save (http://www.vim.org/scripts/script.php?script_id=4521)
"    Plugin Name:  AutoSave
"        Version:  0.1.2
"  Last Modified:  24.04.2013 21:25
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
end

set updatetime=200
au CursorHold,InsertLeave * call AutoSave()
command! AutoSaveToggle :call AutoSaveToggle()

function! AutoSave()
  if g:auto_save >= 1
    let was_modified = &modified
    silent! wa
    if was_modified && !&modified
      echo "(AutoSaved at " . strftime("%T") . ")"
    endif
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
