" [Load plugins] {{{

set runtimepath^=/usr/share/vim/vimfiles"
call plug#begin('~/.config/nvim/plugins')

Plug 'junegunn/vim-plug'
Plug 'dylanaraps/wal.vim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'chrisbra/csv.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/dbext.vim', { 'for': 'sql' }
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
" Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
" Plug 'valloric/youcompleteme'
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }

call plug#end()

" silent !gocode
"}}}

" [General]"{{{

if has("syntax")
  syntax on
  syntax enable
endif

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" load indentation rules and plugins according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

set omnifunc=syntaxcomplete#Complete
" set noshowmode 

let mapleader=" "

" Source vimrc
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
"}}}

" [UI] {{{

colorscheme wal
set notermguicolors
set title       " terminal title

set mouse=a     " Enable mouse usage (all modes)
set showmatch       " Show matching brackets.

set number      " line numbers  
set relativenumber  " line numbers  
nnoremap <leader>m :set invrelativenumber<CR>

set showcmd             " show command in bottom bar
"set cursorline     " highlight current line
set wildmenu            " visual autocomplete for command menu

" set foldenable          " enable folding
" set foldnestmax=2      " 10 nested fold max
set foldlevelstart=9999   " open folds by default
" set foldlevelstart=0   " start with overview
set foldmethod=indent   " fold based on indent level

set scrolloff=9999  " lines around cursor

set nowrap
nnoremap <leader>w :set invwrap<CR>

" }}}

" [Movement] {{{

" Move up/down visual lines
" nnoremap j gj       
" nnoremap k gk

"}}}

" [Tabs]{{{

set tabstop=4
set shiftwidth=4
set expandtab

"}}}

" [Selection]{{{

nnoremap gV `[V`]

"}}}

" [Search]{{{

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
" Show matching searches while typing search/substitute
" split => window with matches
set inccommand=nosplit
nnoremap <leader>l :nohlsearch<CR>

"}}}

" [Tags]

function! UpdateTags()
    if filereadable("tags")
        silent !ctags -R
    endif
endfunction
autocmd BufWritePost * call UpdateTags()

" Performance
" -----------

set autowrite       " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
set noswapfile      " disable annoying startup stuff
set autoread        " watch for file changes

" [WordPerfect]

function! WordPerfect()
    " let lang = a:lang
    " if lang == ""
    "   lang = "nl"
    " endif
    set spell
    set spelllang=nl
    set textwidth=80
    normal mm
    normal gg
    normal gqG
    normal 'm
endfunction

" [Hotkeys]

set clipboard=unnamedplus " use the clipboard (not the primary selection)

nnoremap <leader>y :%y+<CR>

" vnoremap <leader>y "+y
" nnoremap <leader>y ^"+y$
" noremap <leader>p "+p
" vnoremap <leader>d "+d
" nnoremap <leader>d ^"+d$

nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>

nnoremap ; j.

nnoremap <leader>N [s
nnoremap <leader>n ]s

nnoremap <C-d> 5j
vnoremap <C-d> 5j
nnoremap <C-u> 5k
vnoremap <C-u> 5k

" Azerty fix:
nnoremap [ (
nnoremap ] )

autocmd QuickFixCmdPost * cwindow
set grepprg=grep\ -nr\ --exclude=tags
nnoremap <leader>g :silent grep  .<left><left>

" Master Builder
" nnoremap <leader><CR> :write <bar> silent !master-builder %:p<CR>
nnoremap <leader><CR> :make<CR>

" [File(type) specific]
autocmd BufNewFile,BufRead /home/user1/.config/newsboat/* set comments=:#
autocmd BufNewFile,BufRead *.md,*.txt,*.tex set textwidth=80

" Switching current file
" nnoremap <leader><TAB> :bn<CR>
nnoremap <leader><TAB> :b #<CR>

nnoremap <leader>d :bdelete<CR>

" FZF
let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>f :FZF<CR>
nnoremap <leader>b :FzfBuffers<CR>

" todo
"nunmap <buffer> <Space> :VimTodoListsToggleItem<CR>
"vunmap <buffer> <Space> :'<,'>VimTodoListsToggleItem<CR>
"nnoremap <buffer> <leader><Space> :VimTodoListsToggleItem<CR>
"vnoremap <buffer> <leader><Space> :'<,'>VimTodoListsToggleItem<CR>

function! VimTodoListsCustomMappings()
    nnoremap <buffer> <leader><Space> :VimTodoListsToggleItem<CR>
    vnoremap <buffer> <leader><Space> :VimTodoListsToggleItem<CR>

    nnoremap <buffer> o :VimTodoListsCreateNewItemBelow<CR>
    nnoremap <buffer> O :VimTodoListsCreateNewItemAbove<CR>
    nnoremap <buffer> j :VimTodoListsGoToNextItem<CR>
    nnoremap <buffer> k :VimTodoListsGoToPreviousItem<CR>
    inoremap <buffer> <CR> <ESC>:call VimTodoListsAppendDate()<CR>A<CR><ESC>:VimTodoListsCreateNewItem<CR>
    noremap <buffer> <leader>e :silent call VimTodoListsSetNormalMode()<CR>
    nnoremap <buffer> <Tab> :VimTodoListsIncreaseIndent<CR>
    nnoremap <buffer> <S-Tab> :VimTodoListsDecreaseIndent<CR>
    vnoremap <buffer> <Tab> :VimTodoListsIncreaseIndent<CR>
    vnoremap <buffer> <S-Tab> :VimTodoListsDecreaseIndent<CR>
    inoremap <buffer> <Tab> <ESC>:VimTodoListsIncreaseIndent<CR>A
    inoremap <buffer> <S-Tab> <ESC>:VimTodoListsDecreaseIndent<CR>A
endfunction
let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings'

" Emmet

let g:user_emmmet_install_global = 0
autocmd filetype html nnoremap <buffer> <leader><Space> :Emmet 
autocmd filetype css nnoremap <buffer> <leader><Space> :Emmet 

" dbext
" DBCompleteProcedures
" DBCompleteViews
autocmd FileType sql setlocal commentstring=--\ %s
autocmd Filetype sql DBCompleteTables
autocmd Filetype sql DBCheckModeline
autocmd Filetype sql nnoremap <buffer> <leader><Space> :DBExecSQLUnderCursor<CR>
autocmd Filetype sql vnoremap <buffer> <leader><Space> :DBExecVisualSQL<CR>
" autocmd Filetype sql nnoremap <buffer> <leader><CR> vip:DBExecVisualSQL<CR>
let g:dbext_default_profile_PG = 'type=PGSQL'
" let g:dbext_default_profile_PG = 'type=ODBC:driver=postgres:user=user1:conn_parms=database=home;host=localhost'
let g:dbext_default_profile = 'PG'
" let dbext_default_query_statements = 'select,update,delete,insert,create,grant,alter,call,exec,merge,with,explain,show'
let g:dbext_default_history_file = '/dev/null'

" [EasyAlign] {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}

" [NERTTree]

nnoremap <leader>t :NERDTreeToggle<CR>

" vim:foldmethod=marker
" vim:foldlevel=0
