" Environment {

    set nocompatible

    function! OSX()
        return has('macunix')
    endfunction

    function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction

    function! WINDOWS()
        return has('win16') || has('win32') || has('win64')
    endfunction

    if WINDOWS()
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
        if has('multi_byte')
            set termencoding=cp850
            set encoding=utf-8
            setglobal fileencoding=utf-8
            set fileencodings=ucs-bom,utf-8,gb2312,gbk,gb18030,cp936
        endif
    else
        set termencoding=utf-8
        set encoding=utf-8
        set shell=/bin/sh
    endif

    set fileformats=unix,dos,mac

    scriptencoding utf-8

" }

" Plugins {

    filetype off

    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif

    call plug#begin('~/.vim/plugged')
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Yggdroot/indentLine'
    Plug 'ryanoasis/vim-devicons'
    Plug 'bling/vim-bufferline'
    Plug 'mhinz/vim-startify'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'Raimondi/delimitMate'
    Plug 'tomtom/tcomment_vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'kepbod/quick-scope'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'junegunn/vim-easy-align', { 'on': ['<plug>(EasyAlign)', 'EasyAlign'] }
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'airblade/vim-gitgutter'
    call plug#end()

" }

" General {

    filetype plugin indent on
    syntax on

    set autoread
    set autowrite
    set hidden

    set backup
    set swapfile

    if has('persistent_undo')
        set undofile
        set undolevels=1000
        set undoreload=10000
    endif

    if has('clipboard')
        if has('unnamedplus')
            set clipboard=unnamed,unnamedplus
        else
            set clipboard=unnamed
        endif
    endif

    set viewoptions+=slash,unix
    set viewoptions-=options

" }

" UI {

    if has('gui_running')
        set mouse=a
        set mousehide
        set title
        set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)
        set guioptions-=T
        set guioptions-=m
        set guioptions-=e

        if exists('+lines')
            set lines=40
        endif

        if exists('+columns')
            set columns=130
        endif

        if LINUX()
            set guifont=DejaVuSansMonoForPowerline\ NF\ 12,Consolas\ Regular\ 12,Courier\ New\ Regular\ 12
        elseif OSX()
            set guifont=DejaVuSansMonoForPowerline\ Nerd\ Font:h14,Consolas\ Regular:h14,Courier\ New\ Regular:h14
        elseif WINDOWS()
            set guifont=DejaVuSansMonoForPowerline\ NF:h10,Consolas:h10,Courier_New:h10
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256
        endif
    endif

    if empty($TMUX)
        if has('termguicolors')
            set termguicolors
        endif
    endif

    set background=dark
    colorscheme hybrid_material

    set number
    set linespace=0
    set whichwrap=b,s,h,l,<,>,[,]
    set backspace=indent,eol,start
    set scrolljump=1
    set scrolloff=6
    set shortmess=atI
    set showtabline=2
    set tabpagemax=15
    set splitbelow
    set splitright
    set history=100
    set wildmenu
    set wildmode=list:longest,full

    if has('cmdline_info')
        set showcmd
    endif

    if has('statusline')
        set noshowmode
        set laststatus=2
    endif

    set magic
    set showmatch
    set matchtime=1
    set matchpairs+=<:>
    set incsearch
    set hlsearch
    set ignorecase
    set smartcase

" }

" Formatting {

    set nowrap
    set linebreak
    set formatoptions+=rnlmM
    set textwidth=80
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set expandtab
    set smarttab
    set autoindent
    set smartindent
    set nojoinspaces
    set foldenable
    set foldmethod=marker
    set foldmarker={{{,}}}
    set foldlevel=9999
    set foldlevelstart=0
    set foldcolumn=1

" }

" Key Mappings {

    let mapleader=','
    let g:mapleader=','

    noremap 0 ^
    noremap j gj
    noremap k gk
    noremap Y y$
    noremap <space> :
    noremap <silent>* *zz
    noremap <silent># #zz
    noremap <silent>n nzz
    noremap <silent>N Nzz
    noremap <silent>g* g*zz

    nnoremap <leader>o o<esc>
    nnoremap <leader>O O<esc>
    nnoremap <leader>w :w!<cr>
    nnoremap <leader>q :q<cr>
    nnoremap <leader>n :nohlsearch<cr>
    nnoremap <leader>rn :set relativenumber!<cr>
    nnoremap <leader>ev :tabedit $MYVIMRC<cr>
    nnoremap <leader>sv :source $MYVIMRC<cr>

    nnoremap <leader>tn :tabnew<cr>
    nnoremap <leader>to :tabonly<cr>
    nnoremap <leader>tc :tabclose<cr>
    nnoremap <leader>tm :tabmove 
    nnoremap <leader>tx :tabnext 
    nnoremap <leader>te :tabedit <c-r>=expand('%:p:h')<cr>
    nnoremap <leader>ta gT
    nnoremap <leader>td gt
    let g:lasttab=1
    nnoremap <leader>ts :exe 'tabnext '.g:lasttab<cr>
    autocmd TabLeave * let g:lasttab=tabpagenr()

    nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
    nnoremap <leader>ss :setlocal spell!<cr>
    nnoremap <leader>pp :setlocal paste!<cr>

    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l
    nnoremap <c-k> <c-w>k
    nnoremap <c-j> <c-w>j

    nnoremap [t :tabprev<cr>
    nnoremap ]t :tabnext<cr>
    nnoremap [b :bp<cr>
    nnoremap ]b :bn<cr>

    vnoremap < <gv
    vnoremap > >gv
    vnoremap . :normal .<cr>
    vnoremap <space> zf

    inoremap jj <esc>
    inoremap jk <esc>
    inoremap kk <esc>

    inoremap <c-h> <left>
    inoremap <c-l> <right>
    inoremap <c-k> <up>
    inoremap <c-j> <down>
    inoremap <c-a> <home>
    inoremap <c-e> <end>
    inoremap <c-d> <delete>

" }

" Plugin Settings {

    " Airline {
        let g:airline#extensions#tabline#enabled=1
        let g:airline#extensions#tabline#tab_nr_type=1
        let g:airline#extensions#tabline#formatter='unique_tail'
        let g:airline_powerline_fonts=1
        let g:airline_theme='hybrid'
        nmap <leader>1 <plug>AirlineSelectTab1
        nmap <leader>2 <plug>AirlineSelectTab2
        nmap <leader>3 <plug>AirlineSelectTab3
        nmap <leader>4 <plug>AirlineSelectTab4
        nmap <leader>5 <plug>AirlineSelectTab5
        nmap <leader>6 <plug>AirlineSelectTab6
        nmap <leader>7 <plug>AirlineSelectTab7
        nmap <leader>8 <plug>AirlineSelectTab8
        nmap <leader>9 <plug>AirlineSelectTab9
        nmap <leader>- <plug>AirlineSelectPrevTab
        nmap <leader>= <plug>AirlineSelectNextTab
    " }

    " BufferLine {
        let g:bufferline_echo=0
        let g:bufferline_modified='[+]'
    " }

    " Startify {
        let g:startify_session_dir=$HOME.'/.vim/session'
        nnoremap <leader>st :Startify<cr>
    " }

    " Goyo {
        autocmd! User GoyoEnter Limelight
        autocmd! User GoyoLeave Limelight!
        nnoremap <leader>z :Goyo<cr>
    " }

    " DelimitMate {
        let delimitMate_expand_cr=1
        let delimitMate_expand_space=1
        let delimitMate_balance_matchpairs=1
        let delimitMate_matchpairs='(:),[:],{:}'
    " }

    " QuickScope {
        let g:qs_highlight_on_keys=['f', 'F', 't', 'T']
    " }

    " EasyMotion {
        let g:EasyMotion_smartcase=1
        map <leader><leader>h <plug>(easymotion-linebackward)
        map <leader><leader>l <plug>(easymotion-lineforward)
        map <leader><leader>k <plug>(easymotion-k)
        map <leader><leader>j <plug>(easymotion-j)
        map <leader><leader>. <plug>(easymotion-repeat)
    " }

    " EasyAlign {
        xmap ga <plug>(EasyAlign)
        nmap ga <plug>(EasyAlign)
    " }

    " NERDTree {
        let NERDTreeChDirMode=2
        let NERDTreeShowBookmarks=1
        let NERDTreeShowHidden=1
        let NERDTreeShowLineNumbers=0
        nnoremap <leader>f :NERDTreeToggle<cr>
    " }

    " CtrlP {
        let g:ctrlp_cache_dir=$HOME.'/.vim/cache/ctrlp/'
        let g:ctrlp_working_path_mode=0
        let g:ctrlp_match_window_bottom=1
        let g:ctrlp_max_height=15
        let g:ctrlp_match_window_reversed=0
        let g:ctrlp_mruf_max=500
        let g:ctrlp_follow_symlinks=1
        let g:ctrlp_custom_ignore={
                    \ 'dir': '\v[\/]\.(git|hg|svn|rvm)$',
                    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$'
                    \ }
        nnoremap <leader>b :CtrlPBuffer<cr>
        nnoremap <leader>m :CtrlPMRU<cr>
    " }

    " BufferLine {
        let g:bufferline_echo=0
        let g:bufferline_modified='[+]'
    " }

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<cr>
        nnoremap <silent> <leader>gd :Gdiff<cr>
        nnoremap <silent> <leader>gc :Gcommit<cr>
        nnoremap <silent> <leader>gb :Gblame<cr>
        nnoremap <silent> <leader>gl :Glog<cr>
        nnoremap <silent> <leader>gp :Git push<cr>
        nnoremap <silent> <leader>gr :Gread<cr>
        nnoremap <silent> <leader>gw :Gwrite<cr>
        nnoremap <silent> <leader>ge :Gedit<cr>
        nnoremap <silent> <leader>gi :Git add -p %<cr>
        nnoremap <silent> <leader>gg :SignifyToggle<cr>
    " }

" }

" Functions {

    function! InitializeDirectories()
        let dirs={'backup': 'backupdir', 'view': 'viewdir', 'swap': 'directory', 'undo': 'undodir', 'cache': '', 'session': ''}
        for [name, setting] in items(dirs)
            let dir=$HOME.'/.vim/'.name.'/'
            if !isdirectory(dir)
                if exists('*mkdir')
                    call mkdir(substitute(dir, '/$', '', ''), 'p')
                endif
            endif
            if setting != ''
                exe 'set '.setting.'='.dir
            endif
        endfor
    endfunction

    call InitializeDirectories()

    function! StripTrailingWhitespace()
        let _s=@/
        let l=line('.')
        let c=col('.')
        %s/\s\+$//e
        let @/=_s
        call cursor(l, c)
    endfunction

" }

" Auto Commands {

    autocmd BufEnter * if bufname('') !~ '^\[A-Za-z0-9\]*://' | lcd %:p:h | endif
    autocmd FileType c,cpp,java,javascript,go,python,xml,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd FileType htm,html,xhtml setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType css,scss,sass setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline

" }

