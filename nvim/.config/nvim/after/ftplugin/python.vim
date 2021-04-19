setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent smartindent
setlocal foldmethod=indent

" ale

let g:ale_enabled = 0
let b:ale_linters = ['flake8', 'pylint']
let b:ale_fixers = ['yapf']
let g:ale_python_flake8_options = '--ignore=E302,E305'
let g:ale_python_pylint_options = '-E'
"let g:ale_fix_on_save = 1

noremap <buffer> <leader>cf :ALEFix<CR>
noremap <buffer> <leader>ce :ALEEnable<CR>
noremap <buffer> <leader>cd :ALEDisable<CR>

" vimspector

noremap <leader>dd :call vimspector#Restart()<CR>
noremap <leader>dD :VimspectorReset<CR>
noremap <leader>dc :call vimspector#Continue()<CR>
noremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
noremap <leader>dn :call vimspector#StepOver()<CR>
noremap <leader>dN :call vimspector#StepInto()<CR>
noremap <leader>dp :call vimspector#RunToCursor()<CR>
noremap <leader>ds :call vimspector#Stop()<CR>
