augroup ghcmod
  autocmd!
  autocmd BufWritePost <buffer> :GhcModCheckAndLintAsync
augroup END

let g:ghcmod_open_quickfix_function = 'GhcModQuickFix'
function! GhcModQuickFix()
  :HierUpdate
  cwindow
endfunction

setlocal omnifunc=necoghc#omnifunc
nnoremap <buffer> <Space>ht :GhcModType<CR>
nnoremap <buffer> <Space>hh :GhcModTypeClear<CR>
nnoremap <buffer> <Space>hT :GhcModTypeInsert<CR>
nnoremap <buffer> <Space>hI :<C-u>UniteWithCursorWord haskellimport<CR>
