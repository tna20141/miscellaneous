" Note: the following packages should be installed in order for
" all the plugins to work:
" - git (Duh!)
" - python & python3
" - pip & pip3
" - pip(2) install neovim && pip3 install neovim
" - cmake
" - nodejs & npm
" - xclip
" - ag
" - tidy (for html syntax checking)
" - pug-lint npm module (for pug/jade syntax checking)
" - jshint npm module (for js syntax checking)
" - ctags (ctags -R *)
" - jsctags npm module (see extras dir for how to generate tags file)
" - to be continued...
"================================

" turn off Vi compatibility (this should be put at the beginning)
set nocompatible

" vim home
let s:vim_home=expand("~/.config/nvim")

"============================
" vim-plug installed packages
"============================

" install vim-plug
let s:bundle_home=s:vim_home."/bundle"
let s:plug_tool_home=s:bundle_home."/vim-plug"
if !isdirectory(s:plug_tool_home."/.git")
	silent exec "!mkdir -p ".s:bundle_home
	silent exec "!git clone https://github.com/jwhitley/vim-plug.git ".s:plug_tool_home
	let s:bootstrap=1
endif
exec "set rtp+=".s:plug_tool_home
call plug#begin(s:bundle_home)

" let vim-plug manage itself
Plug 'jwhitley/vim-plug'

" statusline & tabline
Plug 'bling/vim-airline'

" file explorer
Plug 'scrooloose/nerdtree'

" Ctrl-P finder
Plug 'ctrlpvim/ctrlp.vim'

" undo tree visualizer
Plug 'simnalamburt/vim-mundo'

" closing buffers without closing vim windows
Plug 'moll/vim-bbye'

" code auto-completion
" add language supports to the post-update hook as needed
" Note: for tern, I had to change 'stdin_windows' -> 'stdin' in
" tern-completer.py for it to work (probably a python version issue).
" everytime this plugin is updated, go to extras/ & run ./youcompleteme_tern_fix.sh
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clang-completer --tern-completer' }

" generates compiler flags files to be used with YouCompleteMe
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" syntax diagnostic display
Plug 'scrooloose/syntastic'

" syntax highlighting for pug/jade
Plug 'digitaltoad/vim-pug'

" auto insert brackets/quotes... in pairs
Plug 'jiangmiao/auto-pairs'

" easier block commenting
Plug 'tomtom/tcomment_vim'

" easily editing surroundings (brackets, tags...)
Plug 'tpope/vim-surround'

" support repeating of plugin key mappings
Plug 'tpope/vim-repeat'

" tag navigation window
Plug 'majutsushi/tagbar'

" alignment helper
"Plug 'junegunn/vim-easy-align'

" highlighting/handling whitespaces
Plug 'ntpeters/vim-better-whitespace'

" hex editor
Plug 'fidian/hexmode'

" REST console
Plug 'diepm/vim-rest-console'

" additional text highlighting for javascript
Plug 'jelera/vim-javascript-syntax'

" displaying colors from color codes in css files
Plug 'ap/vim-css-color'

" vim syntax file for i3 config file
Plug 'PotatoesMaster/i3-vim-syntax'

" plugin of NERDTree to show git status of files
"Plug 'Xuyuanp/nerdtree-git-plugin'

" show git diff in gutter column
Plug 'airblade/vim-gitgutter'

" git wrapper in vim
Plug 'tpope/vim-fugitive'

" snippets engine (text enpansion)
Plug 'SirVer/ultisnips'

" incremental search
Plug 'haya14busa/incsearch.vim'

" fuzzy search
Plug 'haya14busa/incsearch-fuzzy.vim'

" easier moving around in a file
Plug 'easymotion/vim-easymotion'

" directory search
Plug 'dyng/ctrlsf.vim'

" colorscheme pack
Plug 'flazz/vim-colorschemes'

" display search count && current match number
Plug 'henrik/vim-indexed-search'

" multiple editing
Plug 'terryma/vim-multiple-cursors'

" notice that plugins aren't updated at nvim startup,
" the code snippet below is only for first-time vim-plug installation.
" updating can simple be done by calling :PlugInstall/Update from Command Mode
if exists("s:bootstrap") && s:bootstrap
	unlet s:bootstrap
	autocmd VimEnter * PlugInstall
endif
call plug#end()

"========================
" Vim basic configuration
"========================

" path to init.vim
let g:viminit=s:vim_home."/init.vim"

" add an extra directory to runtimepath for miscellanous files
let s:vim_extra_dir=s:vim_home."/extras"
exec 'set rtp+='.s:vim_extra_dir

" show key pressed in command mode
set showcmd

" tabbing related stuff
set tabstop=4
set shiftwidth=4
" i don't like this option
set softtabstop=0
set noexpandtab

" display tab characters
set list
exec "set listchars=tab:┆\\ "

" line numbering
set number

" encoding
set encoding=utf-8
set fileencoding=utf-8

" map leader key
" also gonna use <leader><leader><...> for second level key mapping
let mapleader=','

" map local leader key
let maplocalleader="\\"

" no backup files
set nobackup
set noswapfile

" undo settings
exec "set undodir=".s:vim_home."/undofiles"
set undofile

" highlight current line
" this could slow vim down, disable it if it does
" set cursorline

" shell settings
set shell=bash

" always show status line
set laststatus=2

" for better displaying
set ttyfast
set lazyredraw

" turn on syntax highlighting (it's on by default, though)
syntax on

" colorscheme
" colorscheme github
colorscheme lucius
LuciusWhite
"colorscheme molokai
"colorscheme hybrid_material

" load ftplugins and indent files
filetype plugin on
filetype plugin indent on

" line wrapping
set wrap
set linebreak
set breakindent

" ignorecase when searching (it's faster this way...)
" plus ctags might need this for binary searching
set ignorecase

" hide buffers instead of closing them completely
set hidden

" always try to resize windows equally after splitting/closing windows
set equalalways

" python interpreters
" setting these options directly to be sure
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'

" save and load sessions automatically at start/quit
" sessions are stored on a per-cwd basis
function! MakeSession()
	if g:sessionfile != ""
		echo "Saving..."
		if (filewritable(g:sessiondir) != 2)
			execute "silent !mkdir -p ".g:sessiondir
			redraw!
		endif
		exe "mksession! ".g:sessionfile
	endif
endfunction
function! LoadSession()
	if argc() == 0
		let g:sessiondir = s:vim_home."/sessions".getcwd()
		let g:sessionfile = g:sessiondir."/session.vim"
		if (filereadable(g:sessionfile))
			execute "source ".g:sessionfile
		else
			echo "No session loaded."
		endif
	else
		let g:sessionfile = ""
		let g:sessiondir = ""
	endif
endfunction
" the 'nested' is because loading session might open some buffers,
" and we want the events to be emitted
autocmd VimEnter * nested :call LoadSession()
autocmd VimLeave * :call MakeSession()

"
" vim basic mappings
"

" change window (not in visual mode)
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" copy to/paste from clipboard
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
vnoremap <leader>p "+p
nnoremap <leader>p "+p

" buffer operations
nnoremap <silent><tab> :bnext<CR>
nnoremap <silent><s-tab> :bprevious<CR>
nnoremap <silent><leader>bd :Bdelete<CR>
nnoremap <silent><leader>bfd :Bdelete!<CR>
nnoremap <silent><leader>bn :enew<CR>
nnoremap <silent><leader>bad :bufdo Bdelete<CR>

" remap C-I and C-O because Tab (C-I) conflicts with buffer operations
nnoremap <leader>i <C-i>
nnoremap <leader>o <C-o>

" key mapping for C code compilation & execution
nnoremap <leader><leader>r :!gcc % -o %.out && ./%.out <CR>

" change current directory to the current file's
nnoremap <leader><leader>. :lcd %:p:h<CR>

"================================
" plugins specific configurations
"================================

" NERDTree
"
noremap <silent><F2> :NERDTreeToggle<CR>
nnoremap <silent><leader><F2> :NERDTreeFind<CR>
let g:NERDTreeChDirMode=2
" this list is surely ongoing...
let g:NERDTreeIgnore=['\~$', '\.o$[[file]]', '\.java$[[file]]', '\.db$[[file]]']
" for now, use the default sort settings
" let g:NERDTreeSortOrder=[]
let g:NERDTreeShowBookmarks=1
" auto close NERDTree before quitting vim (for window rendering reasons)
autocmd VimLeavePre * :NERDTreeClose

" tagbar
"
noremap <silent><F8> :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_foldlevel=0

" airline
"
set noshowmode
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline_powerline_fonts=0
" for fugitive
" let g:airline#entensions#branch#enabled=1
" let g:airline#entensions#branch#format='Git_flow_branch_format'
let g:airline#extensions#tabline#fnamemod=':t'

" ctrlp
"
" this won't do anything if we use a custom file listing command
" let g:ctrlp_custom_ignore={
" 	\ 'dir': '\v[\/]\.(git|svn)$',
" 	\ 'file': '\v\.(exe|so|o|class|out)'
" 	\ }
" custom file listing commmand, using ag and an ignore file (created by hand)
let g:ctrlp_user_command='ag %s -l -g "" -p '.s:vim_extra_dir."/agignore"
let g:ctrlp_working_path_mode='raw'
nnoremap <leader><leader>p :CtrlPTag<CR>
let g:ctrlp_match_window='results:100'
let g:ctrlp_open_multiple_files='i'
" custom features to delete buffers from ctrlp
let g:ctrlp_buffer_func = { 'enter': 'CtrlPBufferMappings' }
function! CtrlPBufferMappings()
	nnoremap <buffer> <silent> <c-q> :call <sid>CtrlPDeleteBuffer()<cr>
endfunction
function! s:CtrlPCloseBuffer(bufline)
	let bufnum = matchlist(a:bufline, '>\s\+\([0-9]\+\)')[1]
	exec "bd" bufnum
	return bufnum
endfunction
function! s:CtrlPDeleteBuffer()
	let marked = ctrlp#getmarkedlist()
	if empty(marked)
		let linenum = line('.')
		call s:CtrlPCloseBuffer(getline('.'))
		exec "norm \<F5>"
		let linebottom = line('$')
		if linenum < linebottom
			exec linenum
		endif
	else
		for fname in marked
			let bufid = fname =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(fname, '\d\+')) : fnamemodify(fname[2:], ':p')
			exec "silent! bdelete" bufid
		endfor
		exec "norm \<F5>"
		call ctrlp#clearmarkedlist()
	endif
endfunction

" vim-mundo
"
nnoremap <silent><F5> :MundoToggle<CR>
let g:mundo_right=1
let g:mundo_preview_bottom=1

" YouCompleteMe
"
let g:ycm_comfirm_extra_conf=0
" this one is the default setting
" let g:ycm_add_preview_to_completeopt=0
" maybe also add 'menuone'?
set completeopt-=preview
let g:ycm_server_python_interpreter=g:python3_host_prog
" the file .ycm_extra_conf.py should be created manually based on
" YouCompleteMe's own extra_conf file
" (I myself remove all the compilation flags except for -Wall)
let g:ycm_global_ycm_extra_conf=s:vim_extra_dir."/ycm_extra_conf.py"
nmap <leader>gf :YcmCompleter GoToDefinition<CR>
nmap <leader>gd :YcmCompleter GoToDeclaration<CR>

" syntastic
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
" set to 0 so it wouldn't interfere with YCM when opening C files
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
" C-family files are already checked by YouCompleteMe
noremap <silent><leader><leader>st :SyntasticToggleMode<CR>
" syntastic seems slow, so switch it to passive mode at start
" and switch it on manually when needed
autocmd VimEnter * :SyntasticToggleMode

" vim-easy-align
"
xmap <leader>ga <Plug>(EasyAlign)
nmap <leader>ga <Plug>(EasyAlign)

" vim-rest-tool
"
let g:vrc_cookie_jar='/tmp/vrc_cookie_jar'

" nerdtree-git-plugin
"
let g:NERDTreeIndicatorMapCustom={
	\ "Modified"  : "✹",
	\ "Staged"    : "✚",
	\ "Untracked" : "✭",
	\ "Renamed"   : "➜",
	\ "Unmerged"  : "═",
	\ "Deleted"   : "✖",
	\ "Dirty"     : "✗",
	\ "Clean"     : "✔︎",
	\ "Unknown"   : "?"
	\ }

" vim-gitgutter
"
let g:gitgutter_max_signs=400

" ultisnips
"
let g:UltiSnipsExpandTrigger='<C-e>'
let g:UltiSnipsJumpForwardTrigger='<C-l>'
let g:UltiSnipsJumpBackwardTrigger='<C-h>'

" vim-better-whitespace
"
autocmd BufWritePre * StripWhitespace

" incsearch.vim
"
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" incsearch-fuzzy.vim
"
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" vim-easymotion
"
let g:EasyMotion_do_mapping=0
nmap <leader>s <Plug>(easymotion-bd-f)
nmap <leader>s <Plug>(easymotion-bd-f2)
" change the map from w to f to mimic vimperator
nmap <leader>f <Plug>(easymotion-bd-w)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
let g:EasyMotion_smartcase=1

" ctrlsf.vim
"
nmap <leader>/ <Plug>CtrlSFPrompt
vmap <leader>/ <Plug>CtrlSFVwordPath
nnoremap <silent><F3> :CtrlSFToggle<CR>
let g:ctrlsf_extra_backend_args={
	\ 'ag': '-p '.s:vim_extra_dir."/agignore"
	\ }
" convenient mapping for finding current file without context lines
" add PATTERN and PATH (%) after this
nmap <leader><leader>/ :CtrlSF -C 0<Space>

" auto-pairs
"
let g:AutoPairsShortcutToggle='<leader>a'

" vim-indexed-search
"
let g:indexed_search_mappings=0
let g:indexed_search_shortmess=1
let g:index_search_numbered_only=1
nmap <silent><leader>n :ShowSearchIndex<CR>
