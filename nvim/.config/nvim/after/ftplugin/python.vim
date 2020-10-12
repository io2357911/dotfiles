setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent smartindent

setlocal foldmethod=indent

" ale

let g:ale_enabled = 0
let b:ale_linters = ['flake8', 'pylint']
let b:ale_fixers = ['yapf']
let g:ale_python_pylint_options = '-E'
"let g:ale_fix_on_save = 1

noremap <buffer> <C-c>f :ALEFix<CR>
noremap <buffer> <C-c>e :ALEEnable<CR>
noremap <buffer> <C-c>d :ALEDisable<CR>
