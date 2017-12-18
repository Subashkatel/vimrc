"----------------------------------------------------------------
"            _
"     _   __(_)___ ___  __________
"    | | / / / __ `__ \/ ___/ ___/
"   _| |/ / / / / / / / /  / /__
"  (_)___/_/_/ /_/ /_/_/   \___/
"
"----------------------------------------------------------------
"  Version : 1.17.9
"  License : MIT
"  Author  : Gerard Bajona
"  URL     : https://github.com/gerardbm/vimrc
"----------------------------------------------------------------
"  Index:
"   1. General settings
"   2. Plugins (Plug)
"   3. Plugins settings
"   4. User interface
"   5. Scheme and colors
"   6. Files and backup
"   7. Buffers management
"   8. Tabs management
"   9. Multiple windows
"  10. Indentation tabs
"  11. Moving around lines
"  12. Paste mode
"  13. Search, vimgrep and grep
"  14. Text edition
"  15. Make settings
"  16. Filetype settings
"  17. Helper functions
"----------------------------------------------------------------

"----------------------------------------------------------------
" 1. General settings
"----------------------------------------------------------------
" Disable vi compatibility
set nocompatible

" Reload .vimrc
nnoremap <F12> :so $MYVIMRC<CR>

" Lines of memory to remember
set history=10000

" Leader key to add extra key combinations
let mapleader = ','
let g:mapleader = ','

" Time delay on <Leader> key
set timeoutlen=3000 ttimeoutlen=100

" Update time
set updatetime=250

" Trigger InsertLeave autocmd
inoremap <C-c> <Esc>

" No need for Ex mode
nnoremap Q <NOP>

" Open help in a vertical window
cnoreabbrev help vert help

" Terminal
if has("terminal")
	nnoremap <silent> <C-t> :call <SID>ToggleTerminal()<CR>
	set termkey=<C-t>
	set termsize=10x0
endif

"----------------------------------------------------------------
" 2. Plugins (Plug)
"----------------------------------------------------------------
" List of plugins installed
call plug#begin('~/.vim/plugged')

	" Statusbar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" Git tools
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/gv.vim'

	" Sessions
	Plug 'xolox/vim-session'
	Plug 'xolox/vim-misc'

	" Tools
	Plug 'scrooloose/nerdcommenter'
	Plug 'scrooloose/nerdtree'
	Plug 'valloric/listtoggle'
	Plug 'majutsushi/tagbar'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'mbbill/undotree'
	Plug 'w0rp/ale'

	" Languages
	Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries'  }
	Plug 'JulesWang/css.vim'
	Plug 'hail2u/vim-css3-syntax'
	Plug 'itspriddle/vim-jquery'
	Plug 'pangloss/vim-javascript'
	Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
	Plug 'maksimr/vim-jsbeautify'
	Plug 'Shougo/neco-syntax'
	Plug 'vim-ruby/vim-ruby'

	" Autocomplete
	Plug 'ervandew/supertab'
	Plug 'Shougo/deoplete.nvim'
	Plug 'Shougo/neopairs.vim'
	Plug 'zchee/deoplete-jedi'
	Plug 'zchee/deoplete-zsh'
	Plug 'zchee/deoplete-go', { 'do': 'make'}
	Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
	Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
	Plug 'othree/jspc.vim'
	Plug 'othree/html5.vim'
	Plug 'eagletmt/neco-ghc'
	Plug 'Rip-Rip/clang_complete'
	Plug 'Shougo/neco-vim'

	" Deoplete, specific for Vim8
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'

	" Snippets
	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'
	Plug 'Shougo/context_filetype.vim'

	" Run code
	Plug 'thinca/vim-quickrun'
	Plug 'Shougo/vimproc.vim', {'do' : 'make'}

	" Edition
	Plug 'junegunn/vim-easy-align'
	Plug 'godlygeek/tabular'
	Plug 'jiangmiao/auto-pairs'
	Plug 'alvan/vim-closetag'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-capslock'
	Plug 'wellle/targets.vim'
	Plug 'christoomey/vim-sort-motion'
	Plug 'terryma/vim-expand-region'
	Plug 'Valloric/MatchTagAlways'
	Plug 'FooSoft/vim-argwrap'

	" Misc
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'joeytwiddle/sexy_scroller.vim'
	Plug 'suan/vim-instant-markdown'
	Plug 'tpope/vim-characterize'
	Plug 'tyru/open-browser.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'mattn/webapi-vim'
	Plug 'mattn/emmet-vim'
	Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

	" Color schemes
	Plug 'gerardbm/vim-atomic'

call plug#end()

"----------------------------------------------------------------
" 3. Plugins settings
"----------------------------------------------------------------
" --- Statusbar ---
" Airline settings
let g:airline_theme                       = 'atomic'
let g:airline_powerline_fonts             = 1
let g:airline#extensions#tabline#enabled  = 1
let g:airline#extensions#tabline#fnamemod = ':t'
call airline#parts#define_accent('mode', 'black')

" --- Git tools ---
" Gitgutter settings
let g:gitgutter_max_signs             = 5000
let g:gitgutter_sign_added            = '+'
let g:gitgutter_sign_modified         = '»'
let g:gitgutter_sign_removed          = '_'
let g:gitgutter_sign_modified_removed = '»╌'
let g:gitgutter_map_keys              = 0
let g:gitgutter_diff_args             = '--ignore-space-at-eol'

nmap <Leader>j <Plug>GitGutterNextHunkzz
nmap <Leader>k <Plug>GitGutterPrevHunkzz
nnoremap <silent> <C-g> :call <SID>ToggleGGPrev()<CR>zz
nnoremap <Leader>gs :GitGutterStageHunk<CR>
nnoremap <Leader>gu :GitGutterUndoHunk<CR>

" Fugitive settings
nnoremap <C-s> :<C-U>call <SID>ToggleGsPrev()<CR>
nnoremap <Leader>gh :Gsdiff<CR>
nnoremap <Leader>gv :Gvdiff<CR>
nnoremap <Leader>gb :Gblame<CR>

" Searching for text added or removed by a commit
nnoremap <Leader>gg :call <SID>GrepWrapper('Glog', '-i -S', '--')<CR>

" GV settings
nnoremap <silent> <C-z> :call <SID>PreventGV()<CR>
vnoremap <silent> <C-z> :call <SID>PreventGV()<CR>

" --- Sessions ---
" Vim-session settings
let g:session_autosave  = 'no'
let g:session_autoload  = 'no'
let g:session_directory = '~/.vim/sessions/'

nnoremap <C-q> :OpenSession<CR>

" --- Tools ---
" NERDCommenter settings
let g:NERDDefaultAlign          = 'left'
let g:NERDSpaceDelims           = 1
let g:NERDCompactSexyComs       = 1
let g:NERDCommentEmptyLines     = 0
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters      = {
	\ 'python': {'left': '#'},
	\ }

nnoremap <Leader>c :call NERDComment(0,'toggle')<CR>
vnoremap <Leader>c :call NERDComment(0,'toggle')<CR>

" NERDTree settings
nnoremap <silent> <C-n> :call <SID>ToggleNTree()<CR>

" ALE settings
let g:ale_linters = {
	\ 'python'     : ['pylint'],
	\ 'javascript' : ['jshint'],
	\ }

" Navigate between errors
nnoremap <Leader>h :lprevious<CR>zz
nnoremap <Leader>l :lnext<CR>zz

" Listtoggle settings
let g:lt_location_list_toggle_map = '<leader>e'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" Tagbar toggle
nnoremap <F7> :TagbarToggle<CR>

" CtrlP settings
let g:ctrlp_map               = '<C-p>'
let g:ctrlp_cmd               = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore     = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_show_hidden       = 1
let g:ctrlp_follow_symlinks   = 1
let g:ctrlp_prompt_mappings   = {
	\ 'PrtHistory(1)'        : ['<C-p>'],
	\ 'PrtHistory(-1)'       : ['<C-n>'],
	\ 'ToggleType(1)'        : ['<C-l>', '<C-up>'],
	\ 'ToggleType(-1)'       : ['<C-h>', '<C-down>'],
	\ 'PrtCurLeft()'         : ['<C-b>', '<Left>'],
	\ 'PrtCurRight()'        : ['<C-f>', '<Right>'],
	\ 'PrtBS()'              : ['<C-s>', '<BS>'],
	\ 'PrtDelete()'          : ['<C-d>', '<DEL>'],
	\ 'PrtDeleteWord()'      : ['<C-w>'],
	\ 'PrtClear()'           : ['<C-u>'],
	\ 'ToggleByFname()'      : ['<C-g>'],
	\ 'AcceptSelection("e")' : ['<C-m>', '<CR>'],
	\ 'AcceptSelection("h")' : ['<C-x>'],
	\ 'AcceptSelection("t")' : ['<C-t>'],
	\ 'AcceptSelection("v")' : ['<C-v>'],
	\ 'OpenMulti()'          : ['<C-o>'],
	\ }

" Undotree toggle
nnoremap <Leader>u :UndotreeToggle<CR>

" --- Languages ---
" Go settings
let g:go_highlight_functions         = 1
let g:go_highlight_methods           = 1
let g:go_highlight_fields            = 1
let g:go_highlight_types             = 1
let g:go_highlight_operators         = 1
let g:go_highlight_build_constraints = 1
let g:go_bin_path                    = expand('~/.gotools')
let g:go_list_type                   = 'quickfix'

" CSS3 settings
augroup VimCSS3Syntax
	autocmd!
	autocmd FileType css setlocal iskeyword+=-
augroup END

" Javascript settings
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow  = 1

" Tern_for_vim settings
let g:tern#command   = ['tern']
let g:tern#arguments = ['--persistent']

" JS-Beautify
let g:config_Beautifier = {}
let g:config_Beautifier['js'] = {}
let g:config_Beautifier['js'].indent_style = 'tab'
let g:config_Beautifier['jsx'] = {}
let g:config_Beautifier['jsx'].indent_style = 'tab'
let g:config_Beautifier['json'] = {}
let g:config_Beautifier['json'].indent_style = 'tab'
let g:config_Beautifier['css'] = {}
let g:config_Beautifier['css'].indent_style = 'tab'
let g:config_Beautifier['html'] = {}
let g:config_Beautifier['html'].indent_style = 'tab'

augroup beautify
	autocmd!
	autocmd FileType javascript nnoremap <buffer> <Leader>bf :call JsBeautify()<cr>
	autocmd FileType javascript vnoremap <buffer> <Leader>bf :call RangeJsBeautify()<cr>
	autocmd FileType json nnoremap <buffer> <Leader>bf :call JsonBeautify()<cr>
	autocmd FileType json vnoremap <buffer> <Leader>bf :call RangeJsonBeautify()<cr>
	autocmd FileType jsx nnoremap <buffer> <Leader>bf :call JsxBeautify()<cr>
	autocmd FileType jsx vnoremap <buffer> <Leader>bf :call RangeJsxBeautify()<cr>
	autocmd FileType html nnoremap <buffer> <Leader>bf :call HtmlBeautify()<cr>
	autocmd FileType html vnoremap <buffer> <Leader>bf :call RangeHtmlBeautify()<cr>
	autocmd FileType css nnoremap <buffer> <Leader>bf :call CSSBeautify()<cr>
	autocmd FileType css vnoremap <buffer> <Leader>bf :call RangeCSSBeautify()<cr>
augroup end

" --- Autocomplete ---
" SuperTab settings
let g:SuperTabDefaultCompletionType = '<TAB>'

" Deoplete settings
" - «Deoplete requires Neovim with Python3 enabled»
let g:python3_host_prog       = '/usr/bin/python3'
let g:python3_host_skip_check = 1

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#omni#functions    = {}

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Python autocompletion
let g:deoplete#sources#jedi#show_docstring = 1

" Go autocompletion
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class    = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache     = 1

" Javascript autocompletion
let g:deoplete#omni#functions.javascript = [
	\ 'tern#Complete',
	\ 'jspc#omni',
	\ ]

" Clang autocompletion
let g:clang_complete_auto              = 0
let g:clang_auto_select                = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings   = 0
let g:clang_use_library                = 1
let g:clang_library_path               = '/usr/lib/llvm-3.8/lib'

" --- Snippets ---
" Neosnippet settings
imap <C-q> <Plug>(neosnippet_expand_or_jump)
smap <C-q> <Plug>(neosnippet_expand_or_jump)
xmap <C-q> <Plug>(neosnippet_expand_target)

" Behaviour like SuperTab
smap <expr><TAB>
	\ neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

augroup all
	autocmd InsertLeave * NeoSnippetClearMarkers
augroup end

" --- Run code ---
" QuickRun settings
let g:quickrun_no_default_key_mappings = 0
let g:quickrun_config = {
	\ '_' : {
		\ 'runner'                        : 'vimproc',
		\ 'runner/vimproc/updatetime'     : 60,
		\ 'outputter'                     : 'buffer',
		\ 'outputter/buffer/split'        : 'vertical 32',
		\ 'outputter/buffer/running_mark' : 'Running...',
		\ },
	\ }

let g:quickrun_config.javascript = {
	\ 'command' : 'node',
	\ }

let g:quickrun_config.go = {
	\ 'command'   : 'go',
	\ 'exec'      : '%c run %s',
	\ 'outputter' : 'buffer',
	\ }

let g:quickrun_config.html = {
	\ 'command' : 'w3m',
	\ 'exec'    : 'tmux new-window %c %s',
	\ }

let g:quickrun_config.markdown = {
	\ 'command' : 'qutebrowser',
	\ }

" --- Edition ---
" Easy align settings
xmap gi <Plug>(EasyAlign)
nmap gi <Plug>(EasyAlign)

" Tabularize (e.g. /= or /:)
vnoremap <Leader>x :Tabularize /

" Tabularize only the first match on the line (e.g. /=.*/)
vnoremap <Leader>X :Tabularize /.*/<Left><Left><Left>

" Auto-apirs settings
let g:AutoPairsFlyMode = 0

" Closetag settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml'
autocmd Filetype php iab <? <?php ?><Left><Left><Left>
autocmd Filetype erb iab <% <% %><Left><Left><Left>

" Surround settings
" Use 'yss?', 'yss%' or 'yss=' to surround a line
autocmd FileType php let b:surround_63 = '<?php \r ?>'
let g:surround_37 = '<% \r %>'
let g:surround_61 = '<%= \r %>'

" Caps Lock settings
imap <expr><C-l> deoplete#smart_close_popup()."\<Plug>CapsLockToggle"
cmap <silent> <C-l> <Plug>CapsLockToggle

" Expand region settings
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" MatchTagAlways settings
let g:mta_filetypes = {
	\ 'html'  : 1,
	\ 'xhtml' : 1,
	\ 'xml'   : 1,
	\ 'jinja' : 1,
	\ 'php'   : 1,
	\ }

" ArgWrap settings
let g:argwrap_tail_comma    = 1
let g:argwrap_padded_braces = '[{'

nnoremap <Leader>W :ArgWrap<CR>

" --- Misc ---
" Vim-tmux navigator settings
let g:tmux_navigator_no_mappings = 1

" Instant markdown settings
let g:instant_markdown_autostart = 0

nnoremap <Leader>im :InstantMarkdownPreview<CR>

" Open-browser settings
let g:openbrowser_browser_commands = [{
	\ 'name': 'w3m',
	\ 'args': 'tmux new-window w3m {uri}',
	\ }]

nmap <Leader>gl <Plug>(openbrowser-open)

" Vimwiki settings
let g:vimwiki_hl_headers    = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_url_maxsave   = 0
let g:vimwiki_list          = [{
	\ 'path': '~/DEV/vimwiki',
	\ 'syntax': 'markdown',
	\ }]

nnoremap <Leader>we :VimwikiToggleListItem<CR>
vnoremap <Leader>we :VimwikiToggleListItem<CR>

"----------------------------------------------------------------
" 4. User interface
"----------------------------------------------------------------
" Set X lines to the cursor when moving vertically
set scrolloff=0

" Always show mode
set showmode

" Show command keys pressed
set showcmd

" Enable the WiLd menu
set wildmenu

" Show the current position
set ruler

" Command bar height
set cmdheight=2

" Backspace works on Insert mode
set backspace=eol,start,indent

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Terminal keycodes
if &term =~ 'screen'
	set <F1>=[11~
	set <F2>=[12~
	set <F3>=[13~
	set <F4>=[14~
	set <F5>=[15~
	set <F6>=[17~
	set <F7>=[18~
	set <F8>=[19~
	set <F9>=[20~
	set <F10>=[21~
	set <F11>=[23~
	set <F12>=[24~
	set <S-F1>=[11;2~
	set <S-F2>=[12;2~
	set <S-F3>=[13;2~
	set <S-F4>=[14;2~
	set <S-F5>=[15;2~
	set <S-F6>=[17;2~
	set <S-F7>=[18;2~
	set <S-F8>=[19;2~
	set <S-F9>=[20;2~
	set <S-F10>=[21;2~
	set <S-F11>=[23;2~
	set <S-F12>=[24;2~
endif

" Mouse
set mouse=a

" Highlight cursor line and cursor column
set cursorline
set nocursorcolumn

" Always show the status line
set laststatus=2

" Change the cursor shape
if &term =~ 'screen'
	if exists('$TMUX')
		let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
		let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
		let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
	else
		let &t_SI = "\<Esc>[6 q"
		let &t_SR = "\<Esc>[4 q"
		let &t_EI = "\<Esc>[2 q"
	endif
endif

" Omni completion
if has('autocmd') && exists('+omnifunc')
autocmd Filetype *
	\ if &omnifunc == "" |
	\     setlocal omnifunc=syntaxcomplete#Complete |
	\ endif
endif

"----------------------------------------------------------------
" 5. Scheme and colors
"----------------------------------------------------------------
" True color
" if has("termguicolors")
"     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"     set termguicolors
" endif

" Syntax highlighting
syntax enable

" Color scheme
colorscheme atomic

" Reload the current colorscheme
nnoremap <F11> :call ReloadColorscheme()<CR>

" Show syntax highlighting groups
nnoremap <Leader>B :call <SID>SynStack()<CR>

"----------------------------------------------------------------
" 6. Files and backup
"----------------------------------------------------------------
" Disable swap files
set noswapfile

" No backup (use Git instead)
set nobackup

" Prevents automatic write backup
set nowritebackup

" Use UTF-8 as default encoding
set encoding=utf8

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Autoread a file when it is changed from the outside
set autoread

" Reload a file when it is changed from the outside
let g:f5msg = 'Buffer reloaded.'
nnoremap <F5> :e<CR>:echo g:f5msg<CR>

" Enable filetype plugins
filetype plugin on
filetype indent on

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" Save the current buffer
nnoremap <Leader>s :update<CR>

" Save all buffers
nnoremap <Leader>S :bufdo update<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
cnoremap WW w !sudo tee > /dev/null %

" Rename file
nnoremap <F2> :call RenameFile()<CR>

" Delete file
nnoremap <Leader><Del>y :call DeleteFile()<CR>

" Work on all file, p.e:
" - yaf (yank all file)
" - vaf (select all file)
onoremap af :<C-U>normal! ggVG<Esc><C-O><C-O>
onoremap aF :<C-U>normal! ggVG"+y<Esc><C-O><C-O>
vnoremap af :<C-U>normal! ggVG<Esc>

" Rename title of tmux tab with current filename
if exists('$TMUX')
	autocmd BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
	autocmd VimLeave * call system("tmux setw automatic-rename")
endif

"----------------------------------------------------------------
" 7. Buffers management
"----------------------------------------------------------------
" Buffer hidden when it is abandoned
set hidden

" Close the current buffer
nnoremap <C-b> :call <SID>OnlyCloseBuffer()<CR>

" Move between buffers
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

" Edit and explore buffers
nnoremap <Leader>bb :edit <C-R>=expand("%:p:h")<CR>/
nnoremap <Leader>bg :buffers<CR>:buffer<Space>

" Switch CWD to the directory of the current buffer
nnoremap <Leader>wd :lcd %:p:h<CR>:pwd<CR>

" Copy the filepath to clipboard
nnoremap <Leader>by :let @+=expand("%:p")<CR>

" Ignore case when autocompletes when browsing files
set fileignorecase

" Specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set showtabline=2
catch
endtry

" Remember info about open buffers on close
" set viminfo^=%

"----------------------------------------------------------------
" 8. Tabs management
"----------------------------------------------------------------
" Create and close tabs
nnoremap <Leader>td :tabclose<CR>
nnoremap <Leader>to :tabonly<CR>

" Open a new tab with the current buffer's path
" Useful when editing files in the same directory
nnoremap <Leader>tt :tabedit <C-R>=expand("%:p:h")<CR>/

" Move tabs position
nnoremap <Leader>tr :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <Leader>ty :execute 'silent! tabmove ' . tabpagenr()<CR>

"----------------------------------------------------------------
" 9. Multiple windows
"----------------------------------------------------------------
" Remap wincmd
map <Leader>. <C-w>

set winminheight=0
set winminwidth=0
set splitbelow
set splitright

" Split windows
map <C-w>- :split<CR>
map <C-w>. :vsplit<CR>
map <C-w>j :close<CR>
map <C-w>x :q!<CR>
map <C-w>, <C-w>=

" Resizing windows
if bufwinnr(1)
	map + :resize +1<CR>
	map - :resize -1<CR>
	map < :vertical resize +1<CR>
	map > :vertical resize -1<CR>
endif

" Toggle resize window
nnoremap <silent> <C-f> :ToggleResize<CR>

" Last, previous and next window; and only one window
nnoremap <silent> <C-w>l :wincmd p<CR>:echo "Last window."<CR>
nnoremap <silent> <C-w>p :wincmd w<CR>:echo "Previous window."<CR>
nnoremap <silent> <C-w>n :wincmd W<CR>:echo "Next window."<CR>
nnoremap <silent> <C-w>o :wincmd o<CR>:echo "Only one window."<CR>

" Move between Vim windows and Tmux panes
" - It requires the corresponding configuration into Tmux.
" - Check it at my .tmux.conf from my dotfiles repository.
" - URL: https://github.com/gerardbm/dotfiles/blob/master/tmux/.tmux.conf
" - Plugin required: https://github.com/christoomey/vim-tmux-navigator
set <M-h>=h
set <M-j>=j
set <M-k>=k
set <M-l>=l

nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
nnoremap <silent> <M-p> :TmuxNavigatePrevious<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader><BS> mmHmt:%s/<C-v><CR>//ge<CR>'tzt`m

"----------------------------------------------------------------
" 10. Indentation tabs
"----------------------------------------------------------------
" Enable autoindent & smartindent
set autoindent
set smartindent

" Use tabs, no spaces
set noexpandtab

" Be smart when using tabs
set smarttab

" Tab size (in spaces)
set shiftwidth=4
set tabstop=4

" Remap indentation
nnoremap <TAB> >>
nnoremap <S-TAB> <<

vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

inoremap <TAB> <C-i>
inoremap <S-TAB> <C-d>

" Don't show tabs
set list

let g:f6msg = 'Toggle list.'
nnoremap <F6> :set list!<CR>:echo g:f6msg<CR>

" Show tabs and end-of-lines
set listchars=tab:│\ ,trail:·

"----------------------------------------------------------------
" 11. Moving around lines
"----------------------------------------------------------------
" Specify which commands wrap to another line
set whichwrap+=<,>,h,l

" Many jump commands move the cursor to the start of line
set nostartofline

" Wrap lines into the window
set wrap

" Don't break the words
" Only works if I set nolist (F6)
set linebreak
set showbreak=├——»

" Stop automatic wrapping
set textwidth=0

" Column at 80 width
set colorcolumn=80

" Listings don't pause
set nomore

" Color column
let g:f10msg = 'Toggle colorcolumn.'
nnoremap <silent> <F10> :call <SID>ToggleColorColumn()<CR>:echo g:f10msg<CR>

" Show line numbers
set number
set numberwidth=2

let g:f3msg = 'Toggle line numbers.'
nnoremap <silent> <F3> :set number!<CR>:echo g:f3msg<CR>

" Set relative line numbers
set relativenumber

let g:f4msg = 'Toggle relative line numbers.'
nnoremap <silent> <F4> :set norelativenumber!<CR>:echo g:f4msg<CR>

" Treat long lines as break lines (useful when moving around in them)
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')

vnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')

nnoremap <Home> g^
nnoremap <End> g$

vnoremap <Home> g^
vnoremap <End> g$

" Toggle the cursor position start/end of the line
nnoremap <silent> ñ :call <SID>ToggleCPosition('')<CR>
vnoremap <silent> ñ <Esc>:call <SID>ToggleCPosition('normal! gv')<CR>

" Move lines
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-k> :m '<-2<CR>gv=gv
inoremap <C-k> <Esc>:m .-2<CR>==gi

nnoremap <C-j> :m .+1<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
inoremap <C-j> <Esc>:m .+1<CR>==gi

" Duplicate a line
nnoremap <Leader>ds yyP
nnoremap <Leader>df yyp

" Folding
set foldmethod=marker

" Return to last edit position when opening files
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

" --- Readline commands ---
"----------------------------------------------------------------
" Move the cursor to the line start
inoremap <C-a> <C-O>0

" Move the cursor to the line end
inoremap <C-e> <C-O>$

" Moves the cursor back one character
inoremap <expr><C-b> deoplete#smart_close_popup()."\<Left>"

" Moves the cursor forward one character
inoremap <expr><C-f> deoplete#smart_close_popup()."\<Right>"

" Remove one character
inoremap <C-s> <BS>
inoremap <C-d> <DEL>

" Command Mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-s> <BS>
cnoremap <C-d> <DEL>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-z> <C-R><C-W>

"----------------------------------------------------------------
" 12. Paste mode
"----------------------------------------------------------------
" Bracketed paste mode
" - Source: https://ttssh2.osdn.jp/manual/en/usage/tips/vim.html
if has("patch-8.0.0238")
	if &term =~ "screen"
		let &t_BE = "\e[?2004h"
		let &t_BD = "\e[?2004l"
		exec "set t_PS=\e[200~"
		exec "set t_PE=\e[201~"
	endif
endif

"----------------------------------------------------------------
" 13. Search, vimgrep and grep
"----------------------------------------------------------------
" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Search, wrap around the end of the buffer
set wrapscan

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" For regular expressions turn magic on
set magic

" Maximum amount of memory in Kbyte used for pattern matching
set maxmempattern=1000

" --- Highlight ---
"----------------------------------------------------------------
" Map <Space> to / (search)
nnoremap <Space> /
nnoremap <Leader><Space> ?

" Highlight the word under the cursor and don't jump to next
nnoremap <silent> <Leader><CR> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hlsearch<CR>

" Highlight the selected text and don't jump to next
vnoremap <silent> <Leader><CR> :<C-U>call <SID>VSetSearch()<CR>:set hlsearch<CR>

" Disable highlight
nnoremap <Leader>m :noh<CR>

" Search into a Visual selection
vnoremap <silent> <Space> :<C-U>call RangeSearch('/')<CR>
	\ :if strlen(g:srchstr) > 0
	\ \|exec '/'.g:srchstr\|endif<CR>n
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>
	\ :if strlen(g:srchstr) > 0
	\ \|exec '?'.g:srchstr\|endif<CR>N

" --- Vimgrep and grep ---
"----------------------------------------------------------------
" Vimgrep the highlight in the current file
nnoremap <Leader>vg :vimgrep /<C-R>//j %<CR>

" Vimgrep the highlight in the current directory and subdirectories
nnoremap <Leader>vf :vimgrep /<C-R>//j **/*.

autocmd QuickfixCmdPre grep,grepadd,vimgrep,vimgrepadd,helpgrep copen

" Grep settings
set grepprg=grep\ -nHi

" Current buffer
nnoremap <Leader>vv :call <SID>GrepWrapper('grep!', '', '%')<CR>

" All loaded buffers
nnoremap <Leader>vb :call setqflist([]) \|
			\ call <SID>GrepWrapper('bufdo grepadd!', '', '%')<CR>

" Current working directory
nnoremap <Leader>vn :call <SID>GrepWrapper('grep!', '-R --exclude-dir={.git,.svn} --exclude=LICENSE', '')<CR>

" Current buffer (grepadd)
nnoremap <Leader>vm :call <SID>GrepWrapper('grepadd!', '', '%')<CR>

" Current arglist
nnoremap <Leader>va :call <SID>GrepWrapper('grep!', '', '##')<CR>

" Navigate between vimgrep results
nnoremap <Leader>n :cnext<CR>zz
nnoremap <Leader>N :cprev<CR>zz

" Jump to the results in buffers (first open window), not tabs
set switchbuf=useopen

" --- Replace ---
"----------------------------------------------------------------
" Replace the highlight in the current file
nnoremap <Leader>r :%s/<C-R>///g<Left><Left>

" Replace the highlight in the visual selection
" Flag \%V --> Match only inside the visual selection
vnoremap <Leader>r :s/\%V<C-R>/\%V//g<Left><Left>

" Replace the highlight to all loaded buffers and arglist
nnoremap <Leader>R :bufdo %s/<C-R>///ge<Left><Left><Left>

" Replace the highlight to each valid entry in the quickfix
nnoremap <Leader>Q :cdo %s/<C-R>///ge<Left><Left><Left>

" Populate the arglist
nnoremap <Leader>a :args *.
nnoremap <Leader>A :args **/*.

"----------------------------------------------------------------
" 14. Text edition
"----------------------------------------------------------------
" Toggle case
nnoremap <Leader>z ~
vnoremap <Leader>z y:call setreg('', ToggleCase(@"), getregtype(''))<CR>gv""Pgv
vnoremap ~ y:call setreg('', ToggleCase(@"), getregtype(''))<CR>gv""Pgv

" Toggle and untoggle spell checking
let g:f8msg = 'Toggle spell checking.'
nnoremap <silent> <F8> :setlocal spell!<CR>:echo g:f8msg<CR>

" Toggle spell dictionary
nnoremap <silent> <F9> :call <SID>ToggleSpelllang()<CR>

" Move to next misspelled word
nnoremap ç ]s

" Find the misspelled word before the cursor
nnoremap Ç [s

" Suggest correctly spelled words
nnoremap <Leader>ç z=

" Copy text into the clipboard
vnoremap <Leader>y "+y<Esc>

" Paste text from the clipboard
nnoremap <Leader>p "+p

" Quickly select the text pasted from the clipboard
nnoremap gV `[v`]

" Yank everything from the cursor to the EOL
nnoremap Y y$

" Yank the last pasted text automatically
vnoremap p pgvy

" Retab the selected text
nnoremap <Leader>tf :retab!<CR>
vnoremap <Leader>tf :retab!<CR>

" Isolate the current line
nnoremap <Leader>o m`o<Esc>kO<Esc>``

" Enter a new line Down from 'Normal Mode'
nnoremap <Leader>f mao<Esc>`a

" Enter a new line Up from 'Normal Mode'
nnoremap <Leader>F maO<Esc>`a

"----------------------------------------------------------------
" 15. Make settings
"----------------------------------------------------------------
" Set makeprg
autocmd FileType sh setlocal makeprg=bash\ %
autocmd FileType javascript setlocal makeprg=node\ %
autocmd FileType python setlocal makeprg=python\ %
autocmd FileType ruby setlocal makeprg=ruby\ %
autocmd FileType perl setlocal makeprg=perl\ %
autocmd FileType php setlocal makeprg=php\ %
autocmd FileType go setlocal makeprg=go\ run\ %

if !filereadable(expand('%:p:h').'/Makefile')
	autocmd FileType c setlocal makeprg=gcc\ %\ &&\ ./a.out
endif

" Go to the error line
set errorformat=%m\ in\ %f\ on\ line\ %l

" Execute ':make' and show the result
nnoremap <silent> <Leader><TAB> :<C-u>QuickRun<CR>
vnoremap <silent> <Leader><TAB> :QuickRun<CR>

" Run code into a tmux window
function! Tmuxy(opt) abort
	if exists('$TMUX')
		if a:opt ==# 'python'
			call system("tmux kill-window -t tmuxy")
			call system("tmux new-window -n tmuxy python3 " . expand("%:p"))
		endif
	else
		echo 'Tmux is not running.'
	endif
endfunction

augroup Tmuxy
	autocmd!
	autocmd FileType python nnoremap <Leader>ii :call Tmuxy('python')<CR>
augroup END

"----------------------------------------------------------------
" 16. Filetype settings
"----------------------------------------------------------------
" Delete trailing white space on save
func! DeleteTrailing()
	exe 'normal mz'
	%s/\s\+$//ge
	exe 'normal `z'
endfunc
autocmd BufWrite * :call DeleteTrailing() " All files

" Binary
augroup Binary
	autocmd!
	autocmd BufReadPre  *.bin let &bin=1
	autocmd BufReadPost *.bin if &bin | %!xxd
	autocmd BufReadPost *.bin set ft=xxd | endif
	autocmd BufWritePre *.bin if &bin | %!xxd -r
	autocmd BufWritePre *.bin endif
	autocmd BufWritePost *.bin if &bin | %!xxd
	autocmd BufWritePost *.bin set nomod | endif
augroup end

" Markdown
augroup markdown
	autocmd!
	autocmd FileType markdown setl spell
augroup end

let g:markdown_fenced_languages = [
	\ 'c',
	\ 'sh',
	\ 'go',
	\ 'perl',
	\ 'python',
	\ 'javascript',
	\ 'ruby',
	\ 'eruby',
	\ 'php',
	\ 'html',
	\ 'css',
	\ ]

" Mail
augroup mail
	autocmd!
	autocmd FileType mail setl spell
	autocmd FileType mail setl spelllang=ca
augroup end

" SQL (it requires sqlparse)
augroup sql
	let g:ftplugin_sql_omni_key = '<C-z>'
	autocmd FileType sql nnoremap <Leader>bf
				\ :%!sqlformat --reindent --keywords upper --identifiers upper -<CR>
	autocmd FileType sql vnoremap <Leader>bf
				\ :%!sqlformat --reindent --keywords upper --identifiers upper -<CR>
augroup end

" XML (it requires tidy)
augroup xml
	autocmd FileType xml nnoremap <Leader>bf
				\ :%!tidy -q -i -xml --show-errors 0 -wrap 0 --indent-spaces 4<CR>
augroup end

" New file headers
augroup headers
	autocmd!
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\#
				\ -*- coding: utf-8 -*-\<nl>\"|$
	autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
	autocmd BufNewFile *.pl 0put =\"#!/usr/bin/env perl\<nl>\"|$
	autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
augroup end

"----------------------------------------------------------------
" 17. Helper functions
"----------------------------------------------------------------
" Toggle Terminal
function! s:ToggleTerminal()
	if bufexists('terminal')
		call win_gotoid(s:winZsh)
	else
		execute ':term++close zsh'
		keepalt file terminal
		let s:winZsh = win_getid()
	endif
endfunction

" Reload the current colorscheme
function! ReloadColorscheme()
	try
		exec ':colorscheme ' . g:colors_name
	catch /^Vim:E121/
		exec ':colorscheme default'
	endtry
endfunction

" Show syntax highlighting groups
function! <SID>SynStack()
	if !exists('*synstack')
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" Rename file
function! RenameFile()
	let l:old_name = expand('%')
	let l:new_name = input('New file name: ', expand('%'), 'file')
	if l:new_name !=# '' && l:new_name !=# l:old_name
		exec ':saveas ' . l:new_name
		exec ':silent !rm ' . l:old_name
		redraw!
	endif
endfunction

" Delete file
function! DeleteFile()
	if (&filetype ==# 'help')
		echo "It's a help buffer. Don't delete it."
	else
		call delete(expand('%')) | bdelete!
	endif
endfunction

" Don't close window when deleting a buffer
function! s:OnlyCloseBuffer()
	let l:currentBufNum = bufnr('%')
	let l:alternateBufNum = bufnr('#')

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr('%') == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute('bdelete! '.l:currentBufNum)
	endif
endfunction

" Close the last buffer if it's the last window
" - For 'quickfix' and 'nofile'
autocmd BufEnter * call CloseLastBuffer()
function! CloseLastBuffer()
	if &buftype ==# 'quickfix' || &buftype ==# 'nofile'
		if winnr('$') < 2
			call system("tmux setw automatic-rename")
			quit!
		endif
	endif
endfunction

" Toggle maximize window and resize windows
function! s:ToggleResize() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
		echo 'Windows resized.'
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
		echo 'Window maximized.'
	endif
endfunction
command! ToggleResize call s:ToggleResize()

" Search into a Visual selection
function! RangeSearch(direction)
	call inputsave()
	let g:srchstr = input(a:direction)
	call inputrestore()
	if strlen(g:srchstr) > 0
		let g:srchstr = g:srchstr.
			\ '\%>'.(line("'<")-1).'l'.
			\ '\%<'.(line("'>")+1).'l'
	else
		let g:srchstr = ''
	endif
endfunction

" Highlight the selected text (visual mode)
" Source: https://github.com/nelstrom/vim-visual-star-search
" (You can install it as a plugin)
function! s:VSetSearch()
	let l:temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = l:temp
endfunction

" Count grep matches
function! QFCounter() abort
	let l:results = len(filter(getqflist(), 'v:val.valid'))
	if l:results > 0
		copen
	else
		cclose
	endif
	echo 'Found ' . l:results . ' matches.'
endfunction

" Grep wrapper
function! s:GrepWrapper(cmd, dir, scope) abort
	if a:cmd ==# 'Glog'
		let l:pl = ' '
		let l:pr = ' '
	else
		let l:pl = ' "'
		let l:pr = '" '
	endif
	cclose
	let l:pattern = substitute(@/, '\\V', '', '')
	let l:pattern = substitute(pattern, '\\<', '', '')
	let l:pattern = substitute(pattern, '\\>', '', '')
	silent execute a:cmd . ' ' . a:dir . l:pl . l:pattern . l:pr . a:scope
	redraw!
	set hlsearch
	call QFCounter()
endfunction

" Toggle case
function! ToggleCase(str)
	if a:str ==# toupper(a:str)
		let l:result = tolower(a:str)
	elseif a:str ==# tolower(a:str)
		let l:result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
	else
		let l:result = toupper(a:str)
	endif
	return l:result
endfunction

" Toggle spell dictionary
function! <SID>ToggleSpelllang()
	if (&spelllang =~# 'en')
		set spelllang=ca
		echo 'Català'
	elseif (&spelllang ==# 'ca')
		set spelllang=es
		echo 'Castellano'
	else
		set spelllang=en_us,en_gb
		echo 'English'
	endif
	set spelllang?
endfunction

" New :windo command to return to the last current window
" - Default :windo cycles through all the open windows
" - Use 'Windo' instead of 'windo' to avoid it
command! -nargs=+ -complete=command Windo
	\ let s:currentWindow = winnr() |
	\ execute 'windo <args>' |
	\ exe s:currentWindow . 'wincmd w'

" Toggle colorcolumn
let s:color_column_old = 0

function! s:ToggleColorColumn()
	if s:color_column_old == 0
		let s:color_column_old = &colorcolumn
		Windo let &colorcolumn = 0
	else
		Windo let &colorcolumn = s:color_column_old
		let s:color_column_old = 0
	endif
endfunction

" Toggle the cursor position start/end
let s:togglecp = 0

function! s:ToggleCPosition(visual)
	execute a:visual
	if col('.') >= col('$') - 1
		let s:togglecp = 1
		norm! ^
		echo 'SOT: ^'
	else
		let s:togglecp = 0
		norm! $
		echo 'EOL: $'
	endif
endfunction

" Toggle GitGutterPreviewHunk
function! s:ToggleGGPrev()
	if getwinvar(winnr('#'), '&pvw') == 1
		pclose
		echo 'GitGutter closed.'
	else
		GitGutterPreviewHunk
		if getwinvar(winnr('#'), '&pvw') == 0
			echo 'Nothing to show.'
		else
			echo 'GitGutter preview.'
		endif
	endif
endfunction

" Toggle GstatusPreview
function! s:ToggleGsPrev()
	if &previewwindow
		echo 'Gstatus closed.'
		pclose
	else
		echo 'Gstatus preview.'
		Gstatus
	endif
endfunction

" Execute GV only once
function! s:PreventGV() abort
	if &buftype !=# 'nofile'
		execute ':GV'
	endif
endfunction

" Better toggle for NERDTree
function! s:ToggleNTree()
	if (exists ('t:NERDTreeBufName') && (bufwinnr(t:NERDTreeBufName) != -1))
		if &modifiable
			execute ':NERDTreeFocus'
		else
			execute ':NERDTreeClose'
		endif
	else
		execute ':NERDTreeFind'
	endif
endfunction

" Auto-tabularize a table while editing
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
	let l:p = '^\s*|\s.*\s|\s*$'
	if exists(':Tabularize')
				\ && getline('.') =~# '^\s*|'
				\ && (getline(line('.')-1) =~# l:p
				\ || getline(line('.')+1) =~# l:p)
		let l:column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
		let l:position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
		Tabularize/|/l1
		normal! 0
		call search(repeat('[^|]*|',l:column).'\s\{-\}'.repeat('.',l:position),'ce',line('.'))
	endif
endfunction