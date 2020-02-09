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

" windows encoding switch
map <S-w> :e ++enc=cp1251<CR>

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

Plug 'scrooloose/nerdtree'

nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_max_diagnostics_to_display = 1000
let g:ycm_confirm_extra_conf = 0
highlight YcmErrorSection guibg=#000000

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

autocmd FileType c,cpp,h ClangFormatAutoEnable

Plug 'skywind3000/asyncrun.vim'

noremap <C-m>a :AsyncRun make<CR>
noremap <C-m>c :AsyncRun make clean<CR>
noremap <C-m>w :w \| AsyncRun make<CR>
noremap <C-m>r :AsyncRun make 
noremap <C-m>i :w \| :AsyncRun make 
noremap <C-m>l :silent! :copen<CR>
noremap <C-m>t :UpdateTags -R 
noremap <C-m>b :let @+ = 'b ' . expand('%:t') . ':' . line('.')<CR>
"noremap <C-m>b :let @+ = 'b ' . expand('%:p') . ':' . line('.')<CR>

noremap <C-a>k :!gitk<CR>
noremap <C-a>g :!git gui<CR>

Plug 'dyng/ctrlsf.vim'

let g:ctrlsf_position = 'right'
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
noremap <C-c>s yiw \| :CtrlSF <C-r>"<CR>

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

Plug 'tpope/vim-fugitive'

set previewheight=30

Plug 'tpope/vim-surround'

Plug 'qpkorr/vim-bufkill'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme='base16_google'

Plug 'majutsushi/tagbar'

call plug#end()
