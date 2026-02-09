" =============================================================================
"  .vimrc — Clean Vim 8+ Configuration for HPC Cluster Development
"  Designed for: Any Linux HPC cluster with Vim 8+
"  Languages  : Python, C, C++, CUDA, cuDAQ, Qiskit
"  Last updated: 2026
" =============================================================================

" ---------------------------------------------------------------------------
" 0. COMPATIBILITY
" ---------------------------------------------------------------------------
" Use Vim settings rather than Vi settings. Must be first.
set nocompatible

" Enable file type detection, plugins, and indentation
filetype plugin indent on

" Enable syntax highlighting
syntax on

" ---------------------------------------------------------------------------
" 1. GENERAL SETTINGS
" ---------------------------------------------------------------------------

" --- Line Numbers ---
set number                  " Show absolute line number on current line
set relativenumber          " Show relative line numbers on other lines

" --- Tabs & Indentation ---
set tabstop=4               " A <Tab> character displays as 4 spaces
set softtabstop=4           " Pressing <Tab> inserts 4 spaces
set shiftwidth=4            " Indentation level is 4 spaces
set expandtab               " Convert tabs to spaces (PEP 8 for Python)
set smartindent             " Smart auto-indentation for new lines
set autoindent              " Copy indent from current line to new line

" --- Search ---
set incsearch               " Show matches as you type the search pattern
set hlsearch                " Highlight all search matches
set ignorecase              " Case-insensitive searching...
set smartcase               " ...unless the query contains uppercase letters

" --- Text Display ---
set nowrap                  " Don't wrap long lines (useful for code)
set scrolloff=8             " Keep 8 lines visible above/below the cursor
set sidescrolloff=8         " Keep 8 columns visible left/right of cursor
set colorcolumn=80,120      " Show vertical lines at columns 80 and 120
set cursorline              " Highlight the line the cursor is on
set showmatch               " Briefly highlight matching bracket

" --- UI ---
set noshowmode              " Don't show mode in command line (airline shows it)
set showcmd                 " Show partial commands in bottom right
set cmdheight=2             " More space for displaying messages
set laststatus=2            " Always show the status line
set wildmenu                " Enhanced command-line completion menu
set wildmode=longest:full,full  " Tab-complete longest common, then cycle
set signcolumn=yes          " Always show the sign column (prevents text shift)
set mouse=a                 " Enable mouse support (handy over SSH sometimes)

" --- Performance ---
set updatetime=300          " Faster CursorHold events (default 4000ms)
set timeoutlen=500          " Time to wait for mapped key sequences (ms)
set ttimeoutlen=10          " Time to wait for key codes (snappy Esc in terminal)
set lazyredraw              " Don't redraw screen during macros (faster)
set ttyfast                 " Assume fast terminal connection

" --- Files & Buffers ---
set hidden                  " Allow switching buffers without saving
set noswapfile              " Don't create .swp files
set nobackup                " Don't create backup~ files
set nowritebackup           " Don't create backup before overwriting
set undofile                " Persistent undo across sessions
set undodir=~/.vim/undodir  " Store undo files in a dedicated directory
set encoding=utf-8          " Use UTF-8 encoding
set fileencoding=utf-8      " Write files as UTF-8
set autoread                " Auto-reload files changed outside of Vim

" --- Bells ---
set noerrorbells            " No beeping on errors
set visualbell              " Use visual bell instead of audible
set t_vb=                   " Make visual bell do nothing (silent)

" --- Clipboard ---
" Use system clipboard if available (works on some clusters)
if has('clipboard')
    set clipboard=unnamedplus
endif

" --- Completion ---
set completeopt=menuone,noinsert,noselect  " Better completion popup behavior
set shortmess+=c            " Don't show completion menu messages

" --- Folding ---
set foldmethod=indent       " Fold based on indentation
set foldlevelstart=99       " Start with all folds open

" --- Backspace ---
set backspace=indent,eol,start  " Make backspace work as expected

" ---------------------------------------------------------------------------
" 2. CREATE REQUIRED DIRECTORIES
" ---------------------------------------------------------------------------
" Automatically create the undo directory if it doesn't exist
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p", 0700)
endif

" ---------------------------------------------------------------------------
" 3. PLUGIN MANAGER (vim-plug)
" ---------------------------------------------------------------------------
" Install vim-plug automatically if not present.
" On the cluster, run this once when you first open vim:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then open vim and run :PlugInstall

if filereadable(expand("~/.vim/autoload/plug.vim"))

call plug#begin('~/.vim/plugged')

" --- Color Scheme ---
Plug 'morhetz/gruvbox'                  " Popular dark/light color scheme

" --- Status Line ---
Plug 'vim-airline/vim-airline'          " Lightweight, informative status bar
Plug 'vim-airline/vim-airline-themes'   " Airline theme collection

" --- File Navigation ---
Plug 'preservim/nerdtree'              " File system explorer sidebar
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder binary
Plug 'junegunn/fzf.vim'                " Fuzzy finder Vim integration

" --- Git Integration ---
Plug 'tpope/vim-fugitive'              " Git commands inside Vim (:Git, :Gblame, etc.)
Plug 'airblade/vim-gitgutter'          " Show git diff in the sign column

" --- Code Editing ---
Plug 'tpope/vim-commentary'            " Toggle comments: gcc (line), gc (motion)
Plug 'tpope/vim-surround'              " Surround text with quotes/brackets/tags
Plug 'jiangmiao/auto-pairs'            " Auto-close brackets, quotes, etc.
Plug 'tpope/vim-repeat'                " Make . repeat work with plugin commands

" --- Syntax & Language Support ---
Plug 'sheerun/vim-polyglot'            " Language pack: syntax for 100+ languages
                                       " Includes Python, C, C++, CUDA, and more

" --- Linting & Fixing (Asynchronous — requires Vim 8+) ---
Plug 'dense-analysis/ale'              " Async linting engine for many languages
                                       " Supports: pylint, flake8, gcc, clang, etc.

" --- Undo History ---
Plug 'mbbill/undotree'                 " Visual undo tree browser

" --- Whitespace ---
Plug 'ntpeters/vim-better-whitespace'  " Highlight and strip trailing whitespace

" --- Indentation Guides ---
Plug 'Yggdroot/indentLine'             " Show thin vertical lines at each indent

" --- Tag Support (code navigation for C/C++) ---
Plug 'preservim/tagbar'                " Class/function outline sidebar
                                       " Requires 'ctags' (usually on clusters)

call plug#end()

endif  " end vim-plug check

" ---------------------------------------------------------------------------
" 4. COLOR SCHEME & APPEARANCE
" ---------------------------------------------------------------------------
" Enable 24-bit (true color) if the terminal supports it
if has('termguicolors')
    " Fix true color escape sequences for tmux
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Set gruvbox options before loading the colorscheme
let g:gruvbox_contrast_dark = 'hard'    " Options: 'soft', 'medium', 'hard'
let g:gruvbox_invert_selection = 0      " Don't invert visual selection colors

" Apply color scheme (silent! prevents errors if not yet installed)
set background=dark
silent! colorscheme gruvbox

" Fallback: color the 80-column marker if gruvbox isn't loaded
highlight ColorColumn ctermbg=235 guibg=#3c3836

" ---------------------------------------------------------------------------
" 5. PLUGIN CONFIGURATION
" ---------------------------------------------------------------------------

" --- Airline (status line) ---
let g:airline_theme = 'gruvbox'                " Match the color scheme
let g:airline#extensions#tabline#enabled = 1    " Show buffer tabs at the top
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1        " Show ALE lint status in airline
" Use plain ASCII if your terminal doesn't support special characters
let g:airline_powerline_fonts = 0

" --- NERDTree (file explorer) ---
let g:NERDTreeWinSize = 30              " Width of the NERDTree sidebar
let g:NERDTreeShowHidden = 1            " Show hidden (dot) files
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.o$', '\.so$',
            \ '\.egg-info$', '\.eggs$', 'node_modules']
" Close vim if NERDTree is the only window left
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree')
            \ && b:NERDTree.isTabTree() | quit | endif

" --- FZF (fuzzy finder) ---
" Open fzf in a floating-style popup (Vim 8.2+)
let g:fzf_layout = { 'down': '40%' }
" Use ripgrep for file searching if available (much faster than grep)
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif

" --- ALE (Asynchronous Lint Engine) ---
" ALE runs linters/fixers in the background. Configure per-language below.
let g:ale_linters = {
\   'python':     ['flake8', 'pylint', 'mypy'],
\   'c':          ['gcc', 'clangtidy'],
\   'cpp':        ['g++', 'clangtidy'],
\   'cuda':       ['nvcc'],
\   'sh':         ['shellcheck'],
\}

" Fixers auto-format your code on save (optional — uncomment what you want)
let g:ale_fixers = {
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\   'python':     ['black', 'isort'],
\   'c':          ['clang-format'],
\   'cpp':        ['clang-format'],
\   'cuda':       ['clang-format'],
\}

" ALE behavior settings
let g:ale_fix_on_save = 0               " Set to 1 to auto-fix on save
let g:ale_lint_on_text_changed = 'normal' " Lint while editing in normal mode
let g:ale_lint_on_insert_leave = 1      " Lint when leaving insert mode
let g:ale_lint_on_save = 1              " Lint when saving a file
let g:ale_sign_error = '✘'              " Error sign in the gutter
let g:ale_sign_warning = '⚠'            " Warning sign in the gutter
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_virtualtext_cursor = 0        " Don't show inline virtual text

" Python-specific ALE settings
let g:ale_python_flake8_options = '--max-line-length=120'
let g:ale_python_pylint_options = '--max-line-length=120'

" C/C++ specific: tell ALE where to find compile_commands.json
let g:ale_c_build_dir_names = ['build', 'bin', '_build']
let g:ale_c_parse_compile_commands = 1

" --- GitGutter ---
let g:gitgutter_enabled = 1             " Enable by default
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

" --- Undotree ---
let g:undotree_WindowLayout = 2         " Layout with diff at the bottom
let g:undotree_SetFocusWhenToggle = 1   " Auto-focus the undotree window

" --- IndentLine ---
let g:indentLine_char = '│'             " Character for indent guides
let g:indentLine_enabled = 1

" --- Tagbar ---
" Requires 'ctags' — check with: which ctags
" If not available, install via: module load ctags  (or similar)
let g:tagbar_width = 35
let g:tagbar_autofocus = 1

" --- Better Whitespace ---
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1      " Auto-strip trailing whitespace on save
let g:strip_whitespace_confirm = 0      " Don't ask for confirmation

" ---------------------------------------------------------------------------
" 6. LEADER KEY
" ---------------------------------------------------------------------------
" The leader key is a prefix for custom shortcuts.
" We use <Space> — press Space then the next key(s).
let mapleader = " "

" ---------------------------------------------------------------------------
" 7. KEY MAPPINGS
" ---------------------------------------------------------------------------

" --- Escape Mapping ---
" Press 'jj' quickly in insert mode to return to normal mode.
" This is faster than reaching for the Escape key.
inoremap jj <Esc>

" Also map Ctrl-C to Escape for consistency
inoremap <C-c> <Esc>

" --- Window Navigation ---
" Move between split windows with Space + h/j/k/l
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" --- Window Resizing ---
" Space + / Space - to resize vertical splits
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>= :wincmd =<CR>

" --- File Explorer (NERDTree) ---
" Space + e to toggle the file explorer sidebar
nnoremap <leader>e :NERDTreeToggle<CR>
" Space + nf to find the current file in NERDTree
nnoremap <leader>nf :NERDTreeFind<CR>

" --- Fuzzy Finder (FZF) ---
" Ctrl+P to fuzzy-find files (like VS Code)
nnoremap <C-p> :Files<CR>
" Space + ff to search files
nnoremap <leader>ff :Files<CR>
" Space + fg to live-grep through file contents (requires ripgrep)
nnoremap <leader>fg :Rg<CR>
" Space + fb to search open buffers
nnoremap <leader>fb :Buffers<CR>
" Space + fh to search help tags
nnoremap <leader>fh :Helptags<CR>
" Space + fl to search lines in current buffer
nnoremap <leader>fl :BLines<CR>
" Space + fr to search recently opened files
nnoremap <leader>fr :History<CR>

" --- Git (Fugitive) ---
" Space + gs to open Git status
nnoremap <leader>gs :Git<CR>
" Space + gd to open Git diff
nnoremap <leader>gd :Gdiffsplit<CR>
" Space + gb to open Git blame
nnoremap <leader>gb :Git blame<CR>
" Space + gl to open Git log
nnoremap <leader>gl :Git log --oneline<CR>

" --- ALE Linting Navigation ---
" Space + an to jump to next lint error/warning
nnoremap <leader>an :ALENext<CR>
" Space + ap to jump to previous lint error/warning
nnoremap <leader>ap :ALEPrevious<CR>
" Space + af to fix the current file with ALE
nnoremap <leader>af :ALEFix<CR>
" Space + ad to show detailed error info
nnoremap <leader>ad :ALEDetail<CR>
" Space + at to toggle ALE on/off
nnoremap <leader>at :ALEToggle<CR>

" --- Undotree ---
" Space + u to toggle the undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" --- Tagbar ---
" Space + t to toggle the tagbar (class/function outline)
nnoremap <leader>t :TagbarToggle<CR>

" --- Buffer Management ---
" Space + bn for next buffer, Space + bp for previous buffer
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
" Space + bd to delete (close) the current buffer
nnoremap <leader>bd :bdelete<CR>
" Tab / Shift-Tab to cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" --- Line Moving ---
" Move selected lines up/down in visual mode with J/K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" --- Better Paste ---
" In visual mode, paste without overwriting the register
vnoremap <leader>p "_dP

" --- Delete Without Yanking ---
" In visual mode, X deletes to the black hole register
vnoremap X "_d

" --- Quick Save ---
" Space + w to save the current file
nnoremap <leader>w :w<CR>
" Space + q to quit
nnoremap <leader>q :q<CR>
" Space + wq to save and quit
nnoremap <leader>wq :wq<CR>

" --- Clear Search Highlighting ---
" Space + / to clear highlighted search results
nnoremap <leader>/ :nohlsearch<CR>

" --- Source vimrc ---
" Space + sv to reload this config file
nnoremap <leader>sv :source $MYVIMRC<CR>

" --- Typo Protection ---
" Common typo: :W instead of :w
command! W w
command! Q q
command! Wq wq
command! WQ wq

" ---------------------------------------------------------------------------
" 8. LANGUAGE-SPECIFIC SETTINGS
" ---------------------------------------------------------------------------

augroup lang_settings
    autocmd!

    " --- Python ---
    " PEP 8 style: 4-space indent, 120 max line length
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal colorcolumn=80,120
    autocmd FileType python setlocal textwidth=120
    " Add common Python shebang with Space + pp
    autocmd FileType python nnoremap <buffer> <leader>pp
                \ ggiimport sys<CR>import os<CR><Esc>

    " --- C / C++ ---
    " 4-space indent (adjust to your project's style)
    autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType c,cpp setlocal expandtab
    autocmd FileType c,cpp setlocal colorcolumn=80,120
    " Quick compile shortcut: Space + cc
    autocmd FileType c nnoremap <buffer> <leader>cc :!gcc -Wall -Wextra -o %:r % && ./%:r<CR>
    autocmd FileType cpp nnoremap <buffer> <leader>cc :!g++ -std=c++17 -Wall -Wextra -o %:r % && ./%:r<CR>

    " --- CUDA (.cu files) ---
    autocmd BufRead,BufNewFile *.cu  setlocal filetype=cuda
    autocmd BufRead,BufNewFile *.cuh setlocal filetype=cuda
    autocmd FileType cuda setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType cuda setlocal expandtab
    " Use C++ syntax highlighting as base for CUDA
    autocmd FileType cuda setlocal syntax=cpp
    " Quick CUDA compile: Space + cc
    autocmd FileType cuda nnoremap <buffer> <leader>cc :!nvcc -o %:r % && ./%:r<CR>

    " --- cuDAQ (.cpp files with cuDAQ — uses standard C++ filetype) ---
    " cuDAQ files typically use .cpp extension. Compile with nvq++:
    " You can manually set filetype or use this mapping:
    autocmd FileType cpp nnoremap <buffer> <leader>cq :!nvq++ -o %:r % && ./%:r<CR>

    " --- Qiskit (Python-based — no special filetype needed) ---
    " Qiskit uses standard Python. The Python settings above apply.
    " Tip: Use a conda environment with qiskit installed for linting.

    " --- Shell Scripts ---
    autocmd FileType sh,bash setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " --- Makefiles (must use real tabs) ---
    autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8

    " --- SLURM job scripts (treat as bash) ---
    autocmd BufRead,BufNewFile *.slurm setlocal filetype=sh
    autocmd BufRead,BufNewFile *.sbatch setlocal filetype=sh

    " --- JSON ---
    autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " --- YAML ---
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

augroup END

" ---------------------------------------------------------------------------
" 9. UTILITY FUNCTIONS
" ---------------------------------------------------------------------------

" Auto-strip trailing whitespace on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup general_autocmds
    autocmd!
    " Strip whitespace before saving (backup — also done by vim-better-whitespace)
    " autocmd BufWritePre * :call TrimWhitespace()

    " Return to last edit position when opening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                \ | execute "normal! g'\"" | endif
augroup END

" ---------------------------------------------------------------------------
" 10. NETRW SETTINGS (built-in file browser — used when NERDTree not available)
" ---------------------------------------------------------------------------
let g:netrw_browse_split = 2   " Open files in vertical split
let g:netrw_banner = 0         " Hide the banner
let g:netrw_winsize = 25       " Set width to 25%
let g:netrw_liststyle = 3      " Tree-style listing

" ---------------------------------------------------------------------------
" 11. NOTES FOR HPC CLUSTER USAGE
" ---------------------------------------------------------------------------
" On a typical HPC cluster:
"   - Vim 8+ should be available by default
"   - Check with: vim --version | head -1
"   - If Neovim is preferred: module avail neovim
"   - For Python linting, load a Python module first:
"       module load anaconda3  (or your cluster's Python module)
"       pip install --user flake8 pylint black isort mypy
"   - For C/C++ linting, gcc is usually available. For clang:
"       module load gcc-toolset  (or similar, check module avail)
"   - For CUDA:
"       module load cudatoolkit  (or available version)
"   - ripgrep may not be installed — fzf will fall back to 'find'
" ---------------------------------------------------------------------------
