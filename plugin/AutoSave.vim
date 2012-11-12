" ============================================================================
" File:         AutoSave.vim
" Last Changed: 2012-11-12
" ============================================================================

let s:save_cpo = &cpo
set cpo&vim

let g:auto_save=0

set updatetime=330
au CursorHold,InsertLeave * call AutoSave()
command! AutoSaveToggle :call ToggleAutoSave()
nmap \ast :AutoSaveToggle<CR>

function! AutoSave()
  if g:auto_save >= 1
    silent! wa
  endif
endfunction

function! ToggleAutoSave()
  if g:auto_save >= 1
    let g:auto_save = 0
    echo "AutoSave is OFF"
  else
    let g:auto_save = 1
    echo "AutoSave is ON"
  endif
endfunction

let &cpo = s:save_cpo
