let data_path = stdpath('data')

syntax on
set mouse-=a
set number
set autoread
set exrc
set secure
set hidden
set nohlsearch

set tabstop=4
set shiftwidth=4
set expandtab

cnoremap w!! w !sudo tee %

" enable views
"au BufWinLeave ?* mkview
"au BufWinEnter ?* silent loadview

noremap <C-u> 3<C-u>
noremap <C-d> 3<C-d>

" tabs
map <M-1> 1gt<CR>
map <M-2> 2gt<CR>
map <M-3> 3gt<CR>
map <M-4> 4gt<CR>
map <M-5> 5gt<CR>

map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

map <M-h> :tabm -1<CR>
map <M-l> :tabm +1<CR>

" windows encoding switch
map <S-w> :e ++enc=cp1251<CR>

" use multiple languages
set keymap=russian-jcukenwin
set iminsert=0

" auto yank to clipboard
autocmd TextYankPost * if v:event.operator ==# 'y' | :let @+ = @" | endif

" save opened buffers
"exec 'set viminfo=%,' . &viminfo

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

noremap <C-k><C-r> :YcmRestartServer<CR>
noremap <C-k><C-f> :YcmCompleter FixIt<CR>
noremap <C-k><C-t> :YcmCompleter GetType<CR>
noremap <C-j> :YcmCompleter GoTo<CR>

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

noremap <C-f> <CR>
noremap <C-f><C-f> :Files<CR>

noremap <C-f><C-j> :BTags<CR>

noremap <C-f><C-t> yiw \| :Tags <C-r>"<CR>
noremap <C-f>T :Tags<CR>

noremap <C-f><C-b> :Buffers<CR>
noremap <C-f><C-m> :!mc<CR>

noremap <C-f><C-a> yiw \| :Ag <C-r>"<CR>
noremap <C-f>A :Ag<CR>

noremap <C-f><C-l> :BLines<CR>

Plug 'rhysd/vim-clang-format'

autocmd FileType c,cpp,h ClangFormatAutoEnable

Plug 'skywind3000/asyncrun.vim'

noremap <C-m><C-a> :AsyncRun make<CR>
noremap <C-m><C-c> :AsyncRun make clean<CR>
noremap <C-m><C-w> :w \| AsyncRun make<CR>
noremap <C-m><C-r> :AsyncRun make 
noremap <C-m><C-i> :w \| :AsyncRun make 
noremap <C-m><C-l> :silent! :copen<CR>
noremap <C-m><C-t> :UpdateTags -R 
noremap <C-m><C-b> :let @+ = 'b ' . expand('%:t') . ':' . line('.')<CR>
noremap <C-m><C-k> :AsyncStop!<CR>
"noremap <C-m><C-b> :let @+ = 'b ' . expand('%:p') . ':' . line('.')<CR>

noremap <C-a><C-k> :!gitk<CR>
noremap <C-a><C-g> :!git gui<CR>

" cooperate with vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

Plug 'dyng/ctrlsf.vim'

let g:ctrlsf_position = 'right'
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
noremap <C-c>s yiw \| :CtrlSF <C-r>"<CR>

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags', {'for': ['cpp', 'c', 'h'] }

let g:easytags_file = data_path . '/' . fnamemodify('tags', ':p:gs?/?=?')
let g:easytags_async = 1
let g:easytags_auto_highlight = 0

Plug 'tpope/vim-fugitive'

set previewheight=30

Plug 'airblade/vim-gitgutter'

set updatetime=100

Plug 'sakhnik/nvim-gdb', { 'do': ':UpdateRemotePlugins' }

noremap <C-g>o :GdbStart gdb<CR>
noremap <C-g>b :GdbBreakpointToggle<CR>
noremap <C-g>c :GdbContinue<CR>

Plug 'tpope/vim-surround'

Plug 'qpkorr/vim-bufkill'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme='base16_google'

Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle' }

Plug 'nathanalderson/yang.vim'

Plug 'luochen1990/rainbow'

let g:rainbow_active = 1

call plug#end()
