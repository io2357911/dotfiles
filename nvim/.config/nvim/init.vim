syntax on

set mouse-=a
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set hidden
set noswapfile
set linebreak

set hlsearch incsearch ignorecase smartcase
nnoremap <esc> :noh<return><esc>

cnoremap w!! w !sudo tee %

" enable views
"au BufWinLeave ?* mkview
"au BufWinEnter ?* silent loadview

" tabs

map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

map <M-h> :tabm -1<CR>
map <M-l> :tabm +1<CR>

" windows encoding switch
map <S-w> :e ++enc=cp1251<CR>

" use multiple languages

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

map <M-6> :call ToggleIm()<CR>

function! ToggleIm()
    if &iminsert
        set iminsert=0
        set imsearch=0
    else
        set iminsert=1
        set imsearch=1
    endif
endfunction

" paste markdown link from url in clipboard

noremap <C-c>l :call PasteMdLink()<CR>

function! PasteMdLink()
    let url = @*
    let title = system("echo -n $(wget -qO- '" . url . "' | perl -l -0777 -ne 'print $1 if /<title.*?>\\s*(.*?)\\s*<\\/title/si')")
    exe "normal! a[" . title . "](" . url . ")\<Esc>"
endfunction

" use folds
"set foldmethod=syntax
set nofoldenable

" auto yank to clipboard
autocmd TextYankPost * if v:event.operator ==# 'y' | :let @+ = @" | endif

" save opened buffers
"exec 'set viminfo=%,' . &viminfo

let data_path = stdpath('data')

" swp directory
let &backupdir = data_path . '/'
let &directory = data_path . '/'
let &undodir = data_path . '/'

" completion
set wildmode=list,full
set wildmenu

" vim-plug
call plug#begin(data_path . '/plugged')

let g:plug_window='enew'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer', 'on': 'YcmRestartServer' }

noremap <C-c>r :YcmRestartServer<CR>
noremap <C-c>f :YcmCompleter FixIt<CR>
noremap <C-c>t :YcmCompleter GetType<CR>
noremap <C-j> :YcmCompleter GoTo<CR>

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

noremap <C-f> <CR>
noremap <C-f>f :Files<CR>

noremap <C-f>j :BTags<CR>

noremap <C-f>t yiw \| :Tags <C-r>"<CR>
noremap <C-f>T :Tags<CR>

noremap <C-f>b :Buffers<CR>
noremap <C-f>m :!mc<CR>

noremap <C-f>a yiw \| :Ag <C-r>"<CR>
noremap <C-f>A :Ag<CR>

noremap <C-f>l :BLines<CR>

Plug 'rhysd/vim-clang-format'

noremap <C-c>e :ClangFormatAutoEnable<CR>
noremap <C-c>d :ClangFormatAutoDisable<CR>

Plug 'skywind3000/asyncrun.vim'

noremap <C-m>e :AsyncRun 
noremap <C-m>a :AsyncRun make<CR>
noremap <C-m>c :AsyncRun make clean<CR>
noremap <C-m>w :w \| AsyncRun make<CR>
noremap <C-m>r :AsyncRun make 
noremap <C-m>i :w \| :AsyncRun make 
noremap <C-m>l :silent! :copen<CR>
noremap <C-m>L :silent! :tab copen<CR>
noremap <C-m>t :GutentagsUpdate!<CR>
noremap <C-m>b :let @+ = 'b ' . expand('%:t') . ':' . line('.')<CR>
noremap <C-m>k :AsyncStop!<CR>
"noremap <C-m>b :let @+ = 'b ' . expand('%:p') . ':' . line('.')<CR>

" cooperate with vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

Plug 'dyng/ctrlsf.vim'

let g:ctrlsf_position = 'right'
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
noremap <C-c>s yiw \| :CtrlSF <C-r>"<CR>

Plug 'ludovicchabant/vim-gutentags'

let g:gutentags_cache_dir = data_path
let g:gutentags_ctags_exclude = ['tmp', 'output', 'build', 'package', 'node_modules']

Plug 'tpope/vim-fugitive'

set previewheight=30

noremap <C-g>l :tab Git log --decorate --oneline --graph --pretty=format:"%h%x09%an%x09%ad%x09%s"<CR>
noremap <C-g>s :tab Gstatus<CR>
noremap <C-g>c :Gcommit<CR>
noremap <C-g>p :Gpull<CR>
noremap <C-g>P :Gpush origin 
noremap <C-g>r :Git rebase 
noremap <C-g>k :Git checkout 
noremap <C-g>K :Git checkout .<CR>
noremap <C-g>h :Git stash<CR>
noremap <C-g>H :Git stash pop<CR>

Plug 'airblade/vim-gitgutter'

set updatetime=100

Plug 'sakhnik/nvim-gdb', { 'do': ':UpdateRemotePlugins' }

noremap <C-k>o :GdbStart gdb<CR>
noremap <C-k>b :GdbBreakpointToggle<CR>
noremap <C-k>c :GdbContinue<CR>

Plug 'tpope/vim-surround'

let g:surround_{char2nr('*')} = "**\r**"

Plug 'qpkorr/vim-bufkill'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme='base16_google'
let g:airline_detect_iminsert=1

Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle' }

Plug 'nathanalderson/yang.vim'

Plug 'luochen1990/rainbow'

let g:rainbow_active = 1

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

let g:mkdp_auto_close = 0

noremap <C-m>m :MarkdownPreview<CR>
noremap <C-m>s :MarkdownPreviewStop<CR>

function! g:Open_browser(url)
    silent exec "!chromium --new-window --app=" . a:url . " &"
endfunction
let g:mkdp_browserfunc = 'g:Open_browser'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

let g:vim_markdown_math = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_conceal_code_blocks = 0
set conceallevel=2

Plug 'dense-analysis/ale'

let g:ale_enabled = 0

Plug 'easymotion/vim-easymotion'

map  <space>c <Plug>(easymotion-bd-f)
nmap <space>c <Plug>(easymotion-overwin-f)
.
map <space>l <Plug>(easymotion-bd-jk)
nmap <space>l <Plug>(easymotion-overwin-line)

map <space>w <Plug>(easymotion-bd-w)
nmap <space>w <Plug>(easymotion-overwin-w)

call plug#end()
