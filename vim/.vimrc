

" common


set mouse-=a
syntax on
set number

set exrc
set secure

set hidden

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

noremap <C-u> 3<C-u>
noremap <C-d> 3<C-d>

noremap <C-p> :Files<CR>

" windows encoding switch
map <S-w> :e ++enc=cp1251<CR>


" swp directory


set backupdir=~/.vim/
set directory=~/.vim/
set undodir=~/.vim/


" completion


set wildmode=list,full
set wildmenu


" netrw setup


let g:netrw_banner = 0
let g:netrw_liststyle = 3


" YCM


let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_max_diagnostics_to_display = 1000
let g:ycm_confirm_extra_conf = 0


" ctrlsf


let g:ctrlsf_position = 'right'


" airline-themes


let g:airline_theme='base16_google'


" fugitive


set previewheight=30


" Nerdtree


nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>


" easytags


let g:easytags_file = '~/.vim/' . fnamemodify('tags', ':p:gs?/?=?')
let g:easytags_async = 1
let g:easytags_auto_highlight = 0


" vim-plug


call plug#begin('~/.vim/plugged')

" code support

Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" tags managment

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" refactoring

Plug 'dyng/ctrlsf.vim'

" git

Plug 'tpope/vim-fugitive'

" misc

Plug 'qpkorr/vim-bufkill'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'majutsushi/tagbar'

call plug#end()
