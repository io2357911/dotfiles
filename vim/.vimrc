

" common


set mouse-=a
syntax on
set number

set exrc
set secure


" swp directory


set backupdir=~/.vim//
set directory=~/.vim//
set undodir=~/.vim//


" completion


set wildmode=list,full
set wildmenu


" netrw setup


let g:netrw_banner = 0
let g:netrw_liststyle = 3


" YCM


let g:ycm_autoclose_preview_window_after_completion = 1


" ctrlsf


let g:ctrlsf_position = 'right'


" airline-themes


let g:airline_theme='base16_google'



" fugitive


set previewheight=30


" Nerdtree


nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>


" vim-plug


call plug#begin('~/.vim/plugged')

" code support

Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'vim-syntastic/syntastic'

Plug 'vim-scripts/Conque-GDB'

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



