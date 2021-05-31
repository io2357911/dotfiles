syntax on

set mouse-=a
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set hidden
set noswapfile
set linebreak
set wildmenu wildmode=list,full
set clipboard=unnamedplus
set nostartofline
set foldmethod=syntax
set nofoldenable 
set hlsearch incsearch ignorecase smartcase
set nobackup
set nowritebackup

let mapleader = " "

" use multiple languages

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

noremap <M-k> :call ToggleIm()<CR>
inoremap <M-k> <C-O>:call ToggleIm()<CR>

function! ToggleIm()
    if &iminsert
        set iminsert=0
        set imsearch=0
    else
        set iminsert=1
        set imsearch=1
    endif
endfunction

" tabs

map <C-h> :tabp<CR>
map <C-l> :tabn<CR>
map <C-q> :tabc<CR>
map <M-h> :tabm -1<CR>
map <M-l> :tabm +1<CR>

" termdebug

tnoremap <leader>q <C-\><C-N>
noremap <leader>td :packadd termdebug \| tabnew \| Termdebug<CR>
noremap <leader>tg :Gdb<CR>
noremap <leader>tp :Program<CR>
noremap <leader>ts :Source<CR>
noremap <leader>tr :Run<CR>
noremap <leader>tc :Continue<CR>
noremap <leader>tb :Break<CR>
noremap <leader>tB :Clear<CR>
noremap <leader>tn :Over<CR>
noremap <leader>tN :Step<CR>
noremap <leader>te :Eval 
vnoremap <leader>te :Eval<CR>

" paste a markdown link from a url in the clipboard

noremap <leader>cl :call PasteMdLink(@+)<CR>

function! PasteMdLink(url)
    let title = system("echo -n $(wget -qO- '" . a:url . "' | perl -l -0777 -ne 'print $1 if /<title.*?>\\s*(.*?)\\s*<\\/title/si')")
    exe "normal! a[" . title . "](" . a:url . ")\<Esc>"
endfunction

" misc

nnoremap <esc> :noh<return><esc>
nnoremap <leader>cw :setlocal wrap!<CR>

" swp directory

let data_path = stdpath('data')

let &backupdir = data_path . '/'
let &directory = data_path . '/'
let &undodir = data_path . '/'

" vim-plug

call plug#begin(data_path . '/plugged')

let g:plug_window='enew'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

noremap <M-1> :NERDTreeToggle<CR>
noremap <M-2> :silent! :botright copen \| :resize 10<CR>

autocmd FileType nerdtree,help setlocal number relativenumber

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer', 'on': 'YcmRestartServer' }

noremap <leader>cr :YcmRestartServer<CR>
noremap <leader>cf :YcmCompleter FixIt<CR>
noremap <leader>ct :YcmCompleter GetType<CR>
noremap <leader>j :YcmCompleter GoTo<CR>
noremap <leader>cj :%!python -m json.tool<CR>

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

Plug 'tpope/vim-commentary'

autocmd FileType c,cpp setlocal commentstring=//\ %s

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" noremap <C-f> <CR>
noremap <leader>ff :Files<CR>
noremap <leader>fj :BTags<CR>
noremap <leader>ft yiw \| :Tags <C-r>"<CR>
noremap <leader>fT :Tags<CR>
noremap <leader>fb :Buffers<CR>
noremap <leader>fm :Marks<CR>
noremap <leader>fa yiw \| :Ag <C-r>"<CR>
noremap <leader>fA :Ag<CR>
noremap <leader>fl :BLines<CR>

Plug 'rhysd/vim-clang-format'

noremap <leader>ce :ClangFormatAutoEnable<CR>
noremap <leader>cd :ClangFormatAutoDisable<CR>

Plug 'skywind3000/asyncrun.vim'

noremap <leader>me :AsyncRun 
noremap <leader>ma :AsyncRun make<CR>
noremap <leader>mc :AsyncRun make clean<CR>
noremap <leader>mw :w \| AsyncRun make<CR>
noremap <leader>mr :AsyncRun make 
noremap <leader>mi :w \| :AsyncRun make 
noremap <leader>ml :silent! :tab copen<CR>
noremap <leader>mt :GutentagsUpdate!<CR>
noremap <leader>mb :let @+ = 'b ' . expand('%:t') . ':' . line('.')<CR>
noremap <leader>mk :AsyncStop!<CR>

" cooperate with vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

Plug 'dyng/ctrlsf.vim'

let g:ctrlsf_position = 'right'
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
noremap <leader>cs yiw \| :CtrlSF <C-r>"<CR>

Plug 'ludovicchabant/vim-gutentags'

let g:gutentags_cache_dir = data_path
let g:gutentags_exclude_filetypes = ['markdown']
let g:gutentags_ctags_exclude = ['tmp', 'output*', 'build', 'package', 'node_modules']

Plug 'tpope/vim-fugitive'

noremap <leader>gs :tab Git<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gp :Git pull<CR>
noremap <leader>gP :Git push origin 
noremap <leader>gr :Git rebase 
noremap <leader>gk :Git checkout 
noremap <leader>gK :Git checkout .<CR>
noremap <leader>gh :Git stash<CR>
noremap <leader>gH :Git stash pop<CR>
noremap <leader>gm :.!git rev-parse --abbrev-ref HEAD<CR>
noremap <leader>gl :tab Git log --decorate --oneline --graph --pretty=format:"%h%x09%an%x09%ad%x09%s"<CR>

Plug 'airblade/vim-gitgutter'

set updatetime=100

Plug 'tpope/vim-surround'

let g:surround_{char2nr('*')} = "**\r**"

Plug 'qpkorr/vim-bufkill'

Plug 'morhetz/gruvbox'

let g:gruvbox_guisp_fallback = 'bg'

autocmd vimenter * ++nested colorscheme gruvbox

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_theme='gruvbox'
let g:airline_detect_iminsert=1
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0

Plug 'nathanalderson/yang.vim'

Plug 'luochen1990/rainbow'

let g:rainbow_active = 1

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

let g:mkdp_open_to_the_world = 1
let g:mkdp_auto_close = 0

noremap <leader>cm :MarkdownPreview<CR>
noremap <leader>cM :MarkdownPreviewStop<CR>

function! g:Open_browser(url)
    silent exec "!firefox --new-window " . a:url . " &"
    " silent exec "!chromium --new-window --app=" . a:url . " &"
endfunction
let g:mkdp_browserfunc = 'g:Open_browser'

Plug 'plasticboy/vim-markdown'

let g:vim_markdown_math = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_toc_autofit = 1
set conceallevel=2

noremap <M-3> :Toc<CR>

Plug 'dense-analysis/ale'

let g:ale_enabled = 0

Plug 'puremourning/vimspector'

noremap <leader>dd :call vimspector#Restart()<CR>
noremap <leader>dD :VimspectorReset<CR>
noremap <leader>dj :call vimspector#RunToCursor()<CR>
noremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
noremap <leader>dc :call vimspector#Continue()<CR>
noremap <leader>dp :call vimspector#Pause()<CR>
noremap <leader>dn :call vimspector#StepOver()<CR>
noremap <leader>dN :call vimspector#StepInto()<CR>
noremap <leader>ds :call vimspector#Stop()<CR>
noremap <leader>de :VimspectorEval 

call plug#end()
