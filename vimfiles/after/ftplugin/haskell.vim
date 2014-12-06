augroup ghcmod
  autocmd! BufWritePost <buffer> GhcModCheckAndLintAsync
augroup END

setlocal omnifunc=necoghc#omnifunc
noremap <C-N> :GhcModType<CR>
