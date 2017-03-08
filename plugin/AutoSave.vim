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

if !exists("g:auto_save_silent")
  let g:auto_save_silent = 0
endif

if !exists("g:auto_save_events")
  let g:auto_save_events = [ "InsertLeave", "TextChanged" ]
endif

if !exists("g:auto_save_write_all_buffers")
  let g:auto_save_write_all_buffers = 0
endif

" Like bufdo but restore the current buffer.
function! s:BufDo(command)
  let currBuff=bufnr("%")
  " todo add silent ?
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
" com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

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
      " or http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-buflocal
      " nested => triggers Write/Read events
    execute "au " . event . " * nested  call AutoSaveRun()"
  endfor
augroup END


command! AutoSaveToggleLocal :call AutoSaveToggleLocal()
command! AutoSaveToggleGlobal :call AutoSaveToggleGlobal()
command! AutoSaveCurrentBuffer :call AutoSaveCurrentBuffer()

" function! AutoSaveBuffer()
"     if ShouldItBeSaved()
"         write
"     endif
" endfunc

function! AutoSaveRun()
    call s:BufDo('call AutoSaveCurrentBuffer()')
endfunc

function! s:ShouldItBeSaved()
    return (g:auto_save == 2) || (g:auto_save == 1 && get(b:, 'auto_save', 0))
endfunc

function! AutoSaveCurrentBuffer()
  " if !exists("b:auto_save")
  "   let b:auto_save = 0
  " endif
  if s:ShouldItBeSaved()
    let was_modified = &modified

    " preserve marks that are used to remember start and 
    " end position of the last changed or yanked text (`:h '[`).
    let first_char_pos = getpos("'[")
    let last_char_pos = getpos("']")
    " call DoSave()
    silent! w
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

function! AutoSaveStatus()
    if s:ShouldItBeSaved()
        return "ON"
    else
        return "OFF"
    endif
endfunc

function! AutoSaveToggleGlobal()
    let g:auto_save += 1
    if g:auto_save > 2
        g:auto_save = 0
    endif
endfunction

function! AutoSaveToggleLocal()

    let b:auto_save = get(b:, "auto_save", get(g:, "auto_save"))
    if b:auto_save
        let b:auto_save = v:false
    else
        let b:auto_save = v:true
    endif

  echo "AutoSave is ". AutoSaveStatus()
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
