setlocal tabstop=8
setlocal shiftwidth=8
setlocal foldlevelstart=99
setlocal foldmethod=syntax
nnoremap <buffer> <localleader>r :execute '!gcc -o /tmp/a.out '.
	\ shellescape(expand('%:p'), 1).' && /tmp/a.out'<CR>
" this might mess up window layout so use it only when interaction is needed
nnoremap <buffer> <localleader><localleader>r :execute ':terminal gcc -o
	\ /tmp/a.out '.shellescape(expand('%:p'), 1).' && /tmp/a.out'<CR>
" make sure all folds are open when opening a new buffer
normal zR
