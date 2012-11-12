" ============================================================================
" File:         AutoSave.vim
" Last Changed: 2012-11-12
" ============================================================================

let s:save_cpo = &cpo
set cpo&vim

let g:auto_save_file=0

set updatetime=330
au CursorHold,InsertLeave * call AutoSaveFile()
nmap <F12> :call ToggleAutoSaveFile()<CR>

function! AutoSaveFile()
  if g:auto_save_file >= 1
    silent! wa
  endif
endfunction

function! ToggleAutoSaveFile()
  if g:auto_save_file >= 1
    let g:auto_save_file = 0
    echo "AutoSave is OFF"
  else
    let g:auto_save_file = 1
    echo "AutoSave is ON"
  endif
endfunction

let &cpo = s:save_cpo
