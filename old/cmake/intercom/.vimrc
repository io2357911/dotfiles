source ~/.vimrc

"command Build ! echo 123

" tabs

"set tabstop=4
"set softtabstop=4
"set shiftwidth=4

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

"set nocompatible


"set makeprg=cd\ scripts\ &&\ make

" vim-easytags

let g:easytags_file = '~/.vim/.socket.tags'
"let g:easytags_opts = ['--c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++']
let g:easytags_async = 1
let g:easytags_auto_highlight = 0

let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_enable_diagnostic_highlighting = 0

