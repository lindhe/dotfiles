""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""     NeoVim     """""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Andreas Lindhé
" Licence: MIT

"""""""""""""""""""""""""     vim-plug bootstrap     """"""""""""""""""""""{{{
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path
"}}}

""""""""""""""""""""""""""""""     Plugins     """"""""""""""""""""""""""""{{{
let plugin_path = stdpath('data') . '/plugged'
call plug#begin(plugin_path)

" I cannot imagine Vim without these
Plug 'junegunn/vim-easy-align'        " Align on a character: `gaip&`
Plug 'mbbill/undotree'                " Here to save the day
Plug 'tpope/vim-commentary'           " Toggle comments
Plug 'tpope/vim-endwise'              " Autocomplete if ... endif
Plug 'tpope/vim-repeat'               " Make . repeat (some) plugin actions
Plug 'tpope/vim-sensible'             " Fix the stupid things left from Vi
Plug 'tpope/vim-speeddating'          " <c-a> and <c-x> correct with iso dates
Plug 'tpope/vim-surround'             " Affect your surroundings. Example: ds'
Plug 'Einenlum/yaml-revealer'         " Reveals the YAML hierarchy

" Good ones, but dispensible
Plug 'apzelos/blamer.nvim'            " Git blame for Vim
Plug 'jpalardy/vim-slime', { 'branch': 'main' } " A vim plugin to give you some slime.
Plug 'Mofiqul/vscode.nvim'            " VS Code colorscheme

" Not sure about these yet
Plug 'mattn/emmet-vim'                " Emmet abbreviations
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Language specific
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go'

call plug#end()
unlet plugin_path
"}}}

"""""""""""""""""""""""     Plugin Configurations     """""""""""""""""""""{{{

" Blamer
let g:blamer_enabled = 0
let g:blamer_delay = 1000
let g:blamer_prefix = ' <-- '
let g:blamer_date_format = '%Y-%m-%d'
let g:blamer_template = '<commit-short> (<committer>): <summary>'

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | wincmd p | endif

" UltiSnips
let g:UltiSnipsEditSplit="vertical"

" pymode
let g:pymode_options = 0

" vim-easy-align
map ga <Plug>(EasyAlign)

" Terraform
let g:terraform_align=1
let g:terraform_fold_sections=1
" let g:terraform_fmt_on_save=1

" slime
let g:slime_target = "tmux"
let g:slime_paste_file = "/tmp/slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "0"}
let g:slime_dont_ask_default = 1

" vscode
colorscheme vscode

" YAML Revealer
let g:yaml_revealer_separator = "."

"}}}

""""""""""""""""""""""""""""""     Settings     """"""""""""""""""""""""""""""{{{

set undofile
set list listchars=eol:$,tab:>\ ,trail:-,extends:↩,precedes:…,nbsp:+
set smarttab
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set number
set ignorecase
set smartcase
set linebreak
set signcolumn=yes
set splitbelow
set splitright

" Cred: https://www.reddit.com/r/neovim/comments/fyj7mp/comment/fn0ut6o/
let s:winclip = '/mnt/c/Windows/System32/clip.exe'
let s:xclip = '/usr/bin/xclip'
if filereadable(s:xclip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:xclip, @0) | endif
  augroup END
elseif filereadable(s:winclip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:winclip, @0) | endif
  augroup END
endif

"}}}

""""""""""""""""""""""""""""""     Mappings     """""""""""""""""""""""""""{{{
let mapleader = ','
noremap <space> :
cnoremap qq q!
nnoremap <silent> hq :qall<CR>
nnoremap <silent> HQ :qall!<CR>

" Macros
nnoremap <leader><leader> @q
nnoremap <enter> @@

" Tabs
nnoremap <C-t> :tabedit<Space>
nnoremap gf :tabedit <cfile><CR>

" Make line outcommented title
nnoremap <leader>t :call MakeCenterTitle('')<CR>

" Make it possible to exit :terminal mode
" https://vi.stackexchange.com/a/6966/2082
tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <c-w>0 <c-w><c-=>

" <F3> Toggle list
nnoremap <F3> :set list!<CR>
inoremap <F3> <Esc>:set list!<CR>a

" <F6> to remove trailing whitespace
nnoremap <silent> <F6> :%s/\s\+$//<CR>''

" <F7> to cycle spell
nnoremap <F7> :call CycleSpell()<CR>
inoremap <F7> <Esc>:call CycleSpell()<CR>a

" <F9> Turn off LSP
nnoremap <F9> :LspStop<CR>
inoremap <F9> <Esc>:LspStop<CR>a

" <F10> Toggle Blamer
nnoremap <F10> :BlamerToggle<CR>
inoremap <F10> <Esc>:BlamerToggle<CR>a

"}}}

"""""""""""""""""""""""""""""""     Movement     """"""""""""""""""""""""""""""""{{{

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" hjkl --> jklö
noremap l h
noremap ö l
noremap s l

" Make vertical movement work with wrapped lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Less pain with panes
map <silent> <c-right> <c-w><c-h>
map <silent> <c-up> <c-w><c-j>
map <silent> <c-down> <c-w><c-k>
map <silent> <c-left> <c-w><c-l>

"}}}

""""""""""""""""""""""     Filetype customizations     """"""""""""""""""""{{{
" *.vim files
autocmd BufNewFile,BufRead *.vim set foldmethod=marker


" Prepopulate script files with shebang
autocmd BufNewFile  *.sh    0r ~/res/skeleton.sh
autocmd BufNewFile  *.py    0r ~/res/skeleton.py

" Dockerfile
autocmd BufNewFile,BufRead Dockerfile*[^md] set filetype=dockerfile

" *.gitconfig
autocmd BufNewFile,BufRead *.gitconfig set filetype=gitconfig

" *.yaml.gotmpl
autocmd BufNewFile,BufRead *.yaml.gotmpl set filetype=yaml

" kube-config
autocmd BufNewFile,BufRead ~/.kube/config set filetype=yaml

"}}}

""""""""""""""""""""""""     Function definitions     """""""""""""""""""""{{{

" MakeCenterTitle
" Removes surrounding whitespace, and put text at the center of textwidth and
" then padd with comments (or optional other character) around it.
function! MakeCenterTitle(...)
    "{{{

    " Use commenstring character if no other string is specified
    let pad = (a:000 != [] && a:1 != '') ? a:1 : &commentstring[0]

    " Distance between text and padding:
    let safetyDistance = 5

    " Default width is 80 if textwidth=0
    let tw = (&textwidth > 0) ? &textwidth : 80

    " Trim surrounding whitespace
    s/^\s*//
    s/\s*$//

    " Get length of string
    execute "normal $"
    let contentSize = col(".")

    " Stuff happens
    let marginSize = (tw - contentSize)/2
    if (marginSize - safetyDistance > 0)
        let padding = marginSize - safetyDistance
    else
        let padding = 1
    endif
    let sr = marginSize - padding

    " insert leading padding chars
    " insert spacingRight spaces
    " insert trailing padding chars
    if (marginSize > 1)
        center
        exec "normal! 0".padding."r".pad."$".sr."a ".padding."a".pad."0"
    else
        echo "There was an error. Please fix."
    endif

"}}}
endfunction

" CycleSpell
" Cycles between spelllang
function! CycleSpell()
"{{{
    let langs = ['', 'en', 'sv']
    let i = index(langs, &spl)
    let j = (i+1)%len(langs)
    let &spl = langs[j]
    if empty(&spl)
        set nospell
        echo "set nospell"
    else
        set spell
        echo "spelllang=" . &spl
    endif
"}}}
endfunction
"}}}

