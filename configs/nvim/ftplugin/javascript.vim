setlocal tabstop=2
setlocal shiftwidth=2
nnoremap <buffer> <localleader>r :execute '!node '.shellescape(expand('%:p'), 1)<CR>
" this might mess up window layout so use it only when interaction is needed
nnoremap <buffer> <localleader>r :execute ':terminal node '.shellescape(expand('%:p'), 1)<CR>
