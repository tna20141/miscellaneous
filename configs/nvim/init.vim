" Note: the following packages should be installed in order for
" all the plugins to work:
" - git (Duh!)
" - python & python3
" - pip & pip3
" - pip(2) install neovim && pip3 install neovim
"   pip pynvim module
" - cmake
" - nodejs & npm
" - xclip
" - ag
" - tidy (for html syntax checking)
" - pug-lint npm module (for pug/jade syntax checking)
" - eslint npm module (for js syntax checking)
" - ctags (ctags -R *)
" - jsctags npm module (see extras dir for how to generate tags file)
" - tern npm module
" - clang (and libclang)
" - to be continued...
"
" UPDATES: not all of these are needed as e.g. I don't code C anymore

" For first time setup, run :PlugInstall and restart nvim
" To update vim-plug, run :PlugUpgrade
" To update packages, run :PlugUpdate
"
" To update python versions:
" - Install new python version
" - Update the path if necessary (update-alternatives on ubuntu)
" - $ python3 -m pip install --upgrade pip # if necessary
" - $ pip/pip3 install --user neovim # this probably updates python for nvim
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
let s:autoload_dir=s:vim_home."/autoload"
if !filereadable(s:autoload_dir."/plug.vim")
	let s:bootstrap=1
	silent exec "!mkdir -p ".s:autoload_dir
	silent exec "!mkdir -p ".s:bundle_home
	silent exec "!git clone https://github.com/junegunn/vim-plug.git ".s:autoload_dir
endif
call plug#begin(s:bundle_home)

" statusline & tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" file explorer
Plug 'scrooloose/nerdtree'

" Ctrl-P finder
Plug 'ctrlpvim/ctrlp.vim'

" undo tree visualizer
Plug 'simnalamburt/vim-mundo'

" closing buffers without closing vim windows
Plug 'moll/vim-bbye'

" code auto-completion for neovim (asynchonously)
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" reduce code folding computation
" Plug 'Konfekt/FastFold'

" syntax diagnostic display
Plug 'scrooloose/syntastic'

" syntax highlighting for pug/jade
" Plug 'digitaltoad/vim-pug'

" auto insert brackets/quotes... in pairs
Plug 'jiangmiao/auto-pairs'

" auto closing html tag
Plug 'alvan/vim-closetag'

" easier block commenting
" notable mapping keys: g
Plug 'tomtom/tcomment_vim'

" easily editing surroundings (brackets, tags...)
" notable mapping keys: <action key>s
Plug 'tpope/vim-surround'

" support repeating of plugin key mappings
Plug 'tpope/vim-repeat'

" alignment helper
"Plug 'junegunn/vim-easy-align'

" highlighting/handling whitespaces
Plug 'ntpeters/vim-better-whitespace'

" hex editor
Plug 'fidian/hexmode'

" REST console
" notable mapping keys: <C-j>
Plug 'diepm/vim-rest-console'

" additional text highlighting for javascript
Plug 'jelera/vim-javascript-syntax'
" This one is causing huge slowdown when commenting big block of code
" Plug 'othree/yajs.vim'

" jsx
Plug 'maxmellon/vim-jsx-pretty'

" displaying colors from color codes in css files
Plug 'ap/vim-css-color'

" vim syntax file for i3 config file
Plug 'PotatoesMaster/i3-vim-syntax'

" plugin of NERDTree to show git status of files
Plug 'Xuyuanp/nerdtree-git-plugin'

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

" display search count && current match number
Plug 'henrik/vim-indexed-search'

" multiple editing
" notable mapping keys: <C-n>
Plug 'terryma/vim-multiple-cursors'

" displaying 'space character' (space only, not tab) for easy viewing
" this changes the conceal settings, which affects json files, but fine...
Plug 'Yggdroot/indentLine'

" python indentation
Plug 'Vimjas/vim-python-pep8-indent'

" Python syntax highlighting & checking
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" completion framework
" See https://github.com/ncm2/ncm2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" completion sources for ncm2
Plug 'ncm2/ncm2-bufword'
" Path
Plug 'ncm2/ncm2-path'
" Css
Plug 'ncm2/ncm2-cssomni'
" Js
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
" Python
" Needs jedi pip module.
" Need to be careful with virtual environment, since neovim could use the
" python environment in the venv itself!
" For now, setting g:python3_host_prog to an absolute path is enough.
Plug 'ncm2/ncm2-jedi'

" themes/colorschemes
"
" space-vim-dark theme
Plug 'liuchengxu/space-vim-dark'

Plug 'dikiaap/minimalist'

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
" still need this since Yggdroot/indentLine is only for space
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
" disabling it since it looks really bad with Yggdroot/indentLine
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
" colorscheme space-vim-dark
colorscheme minimalist

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

" maybe also add 'menuone'?
" no preview window when auto-completing
set completeopt-=preview

" python interpreters
" setting these options directly to be sure
" let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'

" not even sure what this does... does this just open folds at the beginning?
set nofoldenable
set foldmethod=syntax

" diff window opens vertically
" currently used by vim-fugitive
set diffopt+=vertical

" transparent background
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" save and load sessions automatically at start/quit
" sessions are stored on a per-cwd basis
set sessionoptions=buffers,curdir,winsize
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
	if argc()==0
		let g:sessiondir=s:vim_home."/sessions".getcwd()
		let g:sessionfile=g:sessiondir."/session.vim"
		if (filereadable(g:sessionfile))
			execute "source ".g:sessionfile
		else
			echo "No session loaded."
		endif
	else
		let g:sessionfile=""
		let g:sessiondir=""
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

" change current directory to the current file's
nnoremap <leader><leader>. :lcd %:p:h<CR>

" F5 to refresh the current buffer
nnoremap <F5> :edit<CR>

" <leader>F5 to reload configuration
nnoremap <leader><F5> :exec "source ".g:viminit<CR>

" disable key to Ex mode
:map Q <Nop>

" Use <Tab> to cycle through auto-completion
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

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
let g:airline_theme='simple'

" ctrlp
"
" this won't do anything if we use a custom file listing command
" let g:ctrlp_custom_ignore={
" 	\ 'dir': '\v[\/]\.(git|svn)$',
" 	\ 'file': '\v\.(exe|so|o|class|out)'
" 	\ }
" custom file listing commmand, using ag and an ignore file (created by hand)
let g:ctrlp_user_command='ag %s -l -g "" -p '.s:vim_extra_dir."/agignore"
let g:ctrlp_working_path_mode='wra'
nnoremap <leader><leader>p :CtrlPTag<CR>
nnoremap <silent> <C-o> :CtrlPBuffer<CR>
let g:ctrlp_match_window='results:100'
let g:ctrlp_open_multiple_files='i'
" custom features to delete buffers from ctrlp
let g:ctrlp_buffer_func={ 'enter': 'CtrlPBufferMappings' }
function! CtrlPBufferMappings()
	nnoremap <buffer> <silent> <c-q> :call <sid>CtrlPDeleteBuffer()<cr>
endfunction
function! s:CtrlPCloseBuffer(bufline)
	let bufnum=matchlist(a:bufline, '>\s\+\([0-9]\+\)')[1]
	exec "silent! bdelete" bufnum
	return bufnum
endfunction
function! s:CtrlPDeleteBuffer()
	let marked=ctrlp#getmarkedlist()
	" close the current buffer
	if empty(marked)
		let line=getline('.')
		if line==' == NO ENTRIES =='
			return
		endif
		let linenum=line('.')
		call s:CtrlPCloseBuffer(line)
		exec "norm \<F5>"
		let linebottom=line('$')
		if linenum < linebottom
			exec linenum
		endif
	" close the selected buffer
	else
		for fname in marked
			let bufid=fname=~'\[\d\+\*No Name\]$' ? str2nr(matchstr(fname, '\d\+')) : fnamemodify(fname[2:], ':p')
			exec "silent! bdelete" bufid
		endfor
		exec "norm \<F5>"
		call ctrlp#clearmarkedlist()
	endif
endfunction

" vim-mundo
"
nnoremap <silent><F12> :MundoToggle<CR>
let g:mundo_right=1
let g:mundo_preview_bottom=1

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
" use eslint for js
let g:syntastic_javascript_checkers=['eslint']
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
let g:vrc_curl_opts={
	\ '--cookie': '/tmp/vrc_cookie_jar',
	\ '--cookie-jar': '/tmp/vrc_cookie_jar',
	\ '--location': '',
	\ '--include': '',
	\ '--max-time': 3600,
	\ '--silent': '',
	\ '--show-error': '',
	\}

" nerdtree-git-plugin
"
let g:NERDTreeGitStatusIndicatorMapCustom={
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
" gitgutter uses this to update the gutter in a recent refactoring
" lookout for any anomaly for now
set updatetime=150

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
let g:incsearch#auto_nohlsearch=1
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
" change the mapping to f to mimic vimperator
nmap f <Plug>(easymotion-bd-w)
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
" auto focus on the ctrlsf pane
let g:ctrlsf_auto_focus={
	\ 'at':'done',
	\ 'duration_less_than':1000
	\ }

" auto-pairs
"
let g:AutoPairsCenterLine=0
let g:AutoPairsShortcutToggle='<leader><F3>'

" vim-indexed-search
"
let g:indexed_search_mappings=0
let g:indexed_search_shortmess=1
let g:indexed_search_numbered_only=1
map <silent><F4> :ShowSearchIndex<CR>

" " deoplete
" "
" let g:deoplete#enable_at_startup=1
" " path texts are based from buffer (opened file path) instead of cwd
" let g:deoplete#file#enable_buffer_path=1

" vim-multiple-cursors
"
" avoid conflict with deoplete
" new ver dont have this problem anymore so keep it here and monitor for now
" remember to comment this out when not using deoplete
" function g:Multiple_cursors_before()
" 	call deoplete#disable()
" endfunction
" function g:Multiple_cursors_after()
" 	call deoplete#enable()
" endfunction

" FastFold
"
" let g:fastfold_fold_command_suffixes=['c', 'o', 'R']
" let g:fastfold_fold_movement_command=[]

" vim-javascript-syntax
"
let g:javaScript_fold=1
" open all folds on all window on vim open
" this must be placed after enabling folds
autocmd VimEnter * :windo normal zR

" vim-fugitive
"
nmap <silent><leader>gb :Gblame<CR>

" vim-closetag
"
let g:closetag_filenames='*.html,*.js,*.jsx'
let g:closetag_emptyTags_caseSensitive=1

" semshi
"
" don't display error sign in the sign column
let g:semshi#error_sign=v:false
" avoid instant re-parsing (good for large files)
let g:semshi#update_delay_factor=0.00005

" ncm2
"
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
