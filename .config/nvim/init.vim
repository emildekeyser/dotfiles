" [Load plugins] {{{

set runtimepath^=/usr/share/vim/vimfiles"

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.cache/nvim-plugins')

Plug 'junegunn/vim-plug'
Plug 'dylanaraps/wal.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'chrisbra/csv.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf.vim'
" Plug 'sirver/ultisnips'
Plug 'vim-airline/vim-airline'
" Plug 'valloric/youcompleteme'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'thinca/vim-ref'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Plug 'tpope/vim-dadbod' " dbext
" Plug 'slashmili/alchemist.vim'
Plug 'Glench/Vim-Jinja2-Syntax'

call plug#end()

let g:deoplete#enable_at_startup = 1

"}}}
" [General] {{{

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
set clipboard=unnamedplus " use the clipboard (not the primary selection)
let mapleader=" "
let $ENV = expand("~/.config/zsh/aliases")

"}}}
" [UI] {{{

colorscheme wal
set notermguicolors
set title       " terminal title
set mouse=a     " Enable mouse usage (all modes)
set showmatch       " Show matching brackets.
set number      " line numbers  
set relativenumber  " line numbers  
set showcmd             " show command in bottom bar
" set cursorline     " highlight current line
set wildmenu            " visual autocomplete for command menu
set scrolloff=9999  " lines around cursor
set nowrap

" }}}
" [Folds] {{{

set foldlevelstart=9999   " open folds by default
set foldlevel=9999   " open folds by default
set foldmethod=indent   " fold based on indent level
" set foldenable          " enable folding
" set foldnestmax=2      " 10 nested fold max
" set foldlevelstart=0   " start with overview

"}}}
" [Tabs]{{{

set tabstop=4
" 0 = val of ts
set shiftwidth=0
set expandtab

"}}}
" [Search]{{{

set incsearch  " search as characters are entered
set hlsearch   " highlight matches
set ignorecase " Do case insensitive matching
set smartcase  " Do smart case matching
" Show matching searches while typing search/substitute
" split => window with matches
set inccommand=nosplit

"}}}
" [Tags]{{{

function! UpdateTags()
    if filereadable("tags")
        silent !ctags -R
    endif
endfunction
autocmd BufWritePost * call UpdateTags()

"}}}
" [Performance]{{{

set autowrite  " Automatically save before commands like :next and :make
set hidden     " Hide buffers when they are abandoned
set noswapfile " disable annoying startup stuff
set autoread   " watch for file changes

" }}}
" [Auto spell]{{{

autocmd OptionSet spelllang set spell

"}}}
" [Vim Hotkeys]{{{

nnoremap Y y$
" TODO make this a repeatable command
nnoremap <C-d> 5j
vnoremap <C-d> 5j
nnoremap <C-u> 5k
vnoremap <C-u> 5k
" Move up/down visual lines
" nnoremap j gj       
" nnoremap k gk

nnoremap <leader>g :silent grep 
" nnoremap <leader>g :silent grep  .<left><left>
nnoremap <leader><CR> :make<CR>
nnoremap <leader><TAB> :b #<CR>
nnoremap <leader>d :bdelete<CR>
nnoremap <leader>l :nohlsearch<CR>
nnoremap <leader>w :set invwrap<CR>
nnoremap <leader>m :set invrelativenumber<CR>
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>y :%y+<CR>
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
" Azerty fix:
nnoremap <leader>N [s
nnoremap <leader>n ]s
nnoremap [ (
nnoremap ] )

"}}}
" [Location list]{{{

" retarded
set grepprg=codegrep
autocmd QuickFixCmdPost * cwindow

"}}}
" [Magic files]{{{

autocmd BufWritePost ~/.config/polybar/config call system("polybar-msg cmd restart")
autocmd BufWritePost ~/.config/i3/config call system("i3 reload")

"}}}
" [FZF] {{{

" `Files [PATH]`    | Files (similar to  `:FZF` )
" `GFiles [OPTS]`   | Git files ( `git ls-files` )
" `GFiles?`         | Git files ( `git status` )
" `Buffers`         | Open buffers
" `Colors`          | Color schemes
" `Ag [PATTERN]`    | {ag}{6} search result ( `ALT-A`  to select all,  `ALT-D`  to deselect all)
" `Rg [PATTERN]`    | {rg}{7} search result ( `ALT-A`  to select all,  `ALT-D`  to deselect all)
" `Lines [QUERY]`   | Lines in loaded buffers
" `BLines [QUERY]`  | Lines in the current buffer
" `Tags [QUERY]`    | Tags in the project ( `ctags -R` )
" `BTags [QUERY]`   | Tags in the current buffer
" `Marks`           | Marks
" `Windows`         | Windows
" `Locate PATTERN`  |  `locate`  command output
" `History`         |  `v:oldfiles`  and open buffers
" `History:`        | Command history
" `History/`        | Search history
" `Snippets`        | Snippets ({UltiSnips}{8})
" `Commits`         | Git commits (requires {fugitive.vim}{9})
" `BCommits`        | Git commits for the current buffer
" `Commands`        | Commands
" `Maps`            | Normal mode mappings
" `Helptags`        | Help tags [1]
" `Filetypes`       | File types

function! FZFwithhistory()
    let l:cwd = substitute(getcwd(), "/", "-", "g")
    let l:cwd = expand("~") . "/.local/history/fzf/vim" . l:cwd
    let l:tail = ""
    if !filereadable(expand(l:cwd))
        call writefile([], expand(l:cwd))
    else
        let l:tail = readfile(expand(l:cwd))
        let l:tail = get(l:tail, -1, "")
    endif

    let l:cmd = ":FZF --history " . l:cwd
    if l:tail != ""
        let l:tail = substitute(l:tail, " ", "\\\\ ", "g")
        let l:cmd = l:cmd . " --query " . l:tail . " ."
    endif

    call execute(l:cmd)
endfunction

let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>f :call FZFwithhistory()<CR>
nnoremap <leader>b :FzfBuffers<CR>
nnoremap <leader>L :FzfLines<CR>
nnoremap <leader>t :FzfTags<CR>
nnoremap <leader>T :FzfBTags<CR>
nnoremap <leader>M :FzfMarks<CR>
nnoremap <leader>H :FzfHistory<CR>
nnoremap <leader>u :FzfSnippets<CR>
nnoremap <leader>c :FzfCommands<CR>
noremap <leader>m :FzfMaps<CR>
nnoremap <leader>h :FzfHelptags<CR>
nnoremap <leader>y :FzfFiletypes<CR>

"}}}
" [Markdown]{{{

autocmd BufNewFile,BufRead *.md,*.txt,*.tex set textwidth=80
function! ToggleTodo()
    let ln = line(".")
    let line = getline(ln)
    let pat_mark_todo = '^\(\s*[-+*]\?\s*\)\[ \]'
    let pat_mark_done = '^\(\s*[-+*]\?\s*\)\[X]'
    if line =~ pat_mark_todo
      let line = substitute(line, pat_mark_todo,  '\1[X]', '')
    elseif line =~ pat_mark_done
      let line = substitute(line, pat_mark_done, '\1[ ]', '')
    endif
    call setline(ln, line)
endfunction
autocmd filetype markdown nnoremap <leader><Space> :call ToggleTodo()<CR>
autocmd filetype markdown nnoremap <leader>o o<BS>- [ ] 
autocmd filetype markdown nnoremap <leader>O O<BS>- [ ] 

"}}}
" [EasyAlign] {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

"}}}
" [vim-commentary]{{{

autocmd FileType c,cpp,cs,java set commentstring=//\ %s
autocmd FileType sql set commentstring=--\ %s

" }}}
" [LanguageClient]{{{

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/home/user1/.local/log/ccls'],
    \ 'cpp': ['ccls', '--log-file=/home/user1/.local/log/ccls']
    \ }

let g:LanguageClient_diagnosticsEnable = 0

" let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
" let g:LanguageClient_settingsPath = '/home/YOUR_USERNAME/.config/nvim/settings.json'
" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
"let g:LanguageClient_hasSnippetSupport = 0

" }}}

" vim:foldmethod=marker
" vim:foldlevel=0
