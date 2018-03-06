setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
nnoremap <buffer> <localleader>r :execute '!node '.shellescape(expand('%:p'), 1)<CR>
" this might mess up window layout so use it only when interaction is needed
" nnoremap <buffer> <localleader>r :execute ':terminal node '.shellescape(expand('%:p'), 1)<CR>

" make sure all folds are open when opening a new buffer
" (have to comment this out to enable folding???)
" normal zR

" tern_for_vim mappings
nnoremap <buffer><localleader>d :TernDef<CR>
